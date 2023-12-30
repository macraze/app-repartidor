import 'dart:convert';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';

class OrderService {
  //Servicio para actualizar el status del repartidor global
  Future<String?> postConnectOrderService(
      {required int idRepartidor,
      required int mount,
      required int isOnline}) async {
    final Map<String, dynamic> body = {
      'idrepartidor': idRepartidor,
      'efectivo': mount,
      'online': isOnline
    };

    try {
      final response = await ApiService.post(
          '/repartidor/set-efectivo-mano', jsonEncode(body));
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        return decodedResp['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Servicio que trae la lista de pedidos del repartidor local
  Future<List<Order>> getListOrdersPendingDeliveryLocalService() async {
    try {
      final response = await ApiService.get(
          '/repartidor/get-list-pedidos-pendientes-comercio');
      // log(response.body);
      final data = orderPendingLocalResponseFromJson(response.body);
      return data.data ?? [];
    } catch (e) {
      // log(e.toString());
      throw Exception('Error === $e');
    }
  }

  //Servicio para que el repartidor acepte los pedidos por ids
  Future<String?> postAcceptListOrdersByIdsService(
      {required String ids}) async {
    final Map<String, dynamic> body = {
      'idpedido': ids,
      'repartidor': null,
    };

    try {
      final response = await ApiService.post(
          '/repartidor/set-asignar-pedido2', jsonEncode(body));
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        return decodedResp['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Servicio que trae la lista de pedidos aceptados por el repartidor local
  Future<List<Order>> getListOrdersAcceptedByIdsService(
      {required String ids}) async {
    final Map<String, dynamic> body = {
      'ids': ids,
    };

    try {
      final response = await ApiService.post(
          '/repartidor/get-pedidos-recibidos-group', jsonEncode(body));

      final data = ordersAcceptedResponseFromJson(response.body);

      final list = data.data ?? [];

      final List<Order> mappedData = list.map<Order>((order) {
        return cocinarDataPedido(order: order);
      }).toList();

      return mappedData;
    } catch (e) {
      // log(e.toString());
      throw Exception('Error === $e');
    }
  }

  Order cocinarDataPedido({required Order order}) {
    TimeLine timeLineEntity = order.timeLine ?? TimeLine();
    timeLineEntity.marcarPedidoAceptado();
    order.timeLine = timeLineEntity;

    try {
      final delivery = order.jsonDatosDelivery!.isNotEmpty
          ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
          : JsonDatosDelivery();

      double importeTotal =
          (delivery.pHeader?.arrDatosDelivery?.importeTotal != null)
              ? double.parse(
                  delivery.pHeader?.arrDatosDelivery?.importeTotal.toString() ??
                      '0')
              : 0.0;

      double costoEntrega =
          (delivery.pHeader?.arrDatosDelivery?.costoTotalDelivery != null)
              ? double.parse(delivery
                      .pHeader?.arrDatosDelivery?.costoTotalDelivery
                      .toString() ??
                  '0')
              : 0.0;

      if (costoEntrega == 0) {
        PSubtotale? costoDelivery = delivery.pSubtotales?.firstWhere(
          (x) =>
              x.descripcion!.toLowerCase().contains("delivery") ||
              x.descripcion!.toLowerCase().contains("envio") ||
              x.descripcion!.toLowerCase().contains("entrega"),
          orElse: () => PSubtotale(),
        );

        costoEntrega = costoDelivery?.importe?.toDouble() ?? 0.0;
      }

      if (costoEntrega == 0) {
        delivery.pBody?.tipoconsumo?.forEach((c) {
          c.secciones?.forEach((s) {
            s.items?.forEach((i) {
              String desItem = i.des != '' ? i.des!.toLowerCase() : '';
              if (desItem.contains("delivery") ||
                  desItem.contains("envio") ||
                  desItem.contains("entrega")) {
                costoEntrega += double.parse(i.precioPrint ?? '0');
              }
            });
          });
        });
      }

      double propina = double.parse(
          delivery.pHeader?.arrDatosDelivery?.propina?.importe ?? '0');

      final total = double.parse(importeTotal.toString()) -
          (double.parse(costoEntrega.toString()) +
              double.parse(propina.toString()));

      order.totalPagaRepartidor = total;
      order.propinaRepartidor = propina;
      order.costoDelivery = double.parse(costoEntrega.toString());
    } catch (e) {
      // log(e.toString());
      order.jsonDatosDelivery = null;
      order.totalPagaRepartidor = 0;
    }
    return order;
  }

  //Servicio para que el repartidor acepte los pedidos por ids
  Future<String?> updateToPedidoEntregado({required Order order}) async {
    final User user = userFromJson(LocalStorage.user);
    final delivery = order.jsonDatosDelivery!.isNotEmpty
        ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
        : JsonDatosDelivery();

    bool isRepartidorPropio = UserProvider().isRepartidorPropio;

    int pwaDeliveryComisionFijaNoAfiliado = delivery.pHeader?.arrDatosDelivery
            ?.establecimiento?.pwaDeliveryComisionFijaNoAfiliado ??
        0;

    TimeLine timeLineEntity = order.timeLine ?? TimeLine();
    timeLineEntity.marcarPedidoEntregado();
    order.timeLine = timeLineEntity;

    final costoDelivery = order.costoDelivery ?? 0;
    final propinaRepartidor = order.costoDelivery ?? 0;
    final costoTotalServicio = propinaRepartidor + costoDelivery;

    final importeDepositar =
        double.parse(pwaDeliveryComisionFijaNoAfiliado.toString())
            .toStringAsFixed(2);

    final Map<String, dynamic> body = {
      'idrepartidor': user.idrepartidor,
      'idpedido': order.idpedido,
      'time_line': order.timeLine?.toJson(),
      'idcliente': order.idcliente,
      'idsede': order.idsede,
      'operacion': {
        'isrepartidor_propio': isRepartidorPropio,
        'metodoPago': delivery.pHeader?.arrDatosDelivery?.metodoPago,
        'importeTotalPedido': order.totalR,
        'importePagadoRepartidor': order.totalPagaRepartidor,
        'comisionRepartidor': isRepartidorPropio ? 0 : order.costoDelivery,
        'propinaRepartidor': isRepartidorPropio ? 0 : order.propinaRepartidor,
        'costoTotalServicio': isRepartidorPropio ? 0.0 : costoTotalServicio,
        'importeDepositar': isRepartidorPropio ? 0 : importeDepositar
      }
    };

    try {
      final response = await ApiService.post(
          '/repartidor/set-fin-pedido-entregado', jsonEncode(body));
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        return decodedResp['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
