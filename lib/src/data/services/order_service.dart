import 'dart:convert';
import 'dart:developer';

import 'package:app_repartidor/src/data/api.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/entities/entities.dart';
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
      final response =
          await Api.post('/repartidor/set-efectivo-mano', jsonEncode(body));
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
      final response =
          await Api.get('/repartidor/get-list-pedidos-pendientes-comercio');
      // log(response.body);
      final data = orderPendingLocalResponseFromJson(response.body);
      return data.data ?? [];
    } catch (e) {
      log(e.toString());
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
      final response =
          await Api.post('/repartidor/set-asignar-pedido2', jsonEncode(body));
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
      final response = await Api.post(
          '/repartidor/get-pedidos-recibidos-group', jsonEncode(body));
      // log(response.body);
      final data = ordersAcceptedResponseFromJson(response.body);

      final list = data.data ?? [];

      final List<Order> mappedData = list.map<Order>((x) {
        return cocinarDataPedido(x);
      }).toList();

      cocinarLisPedidosNotificar(mappedData);

      return mappedData;
    } catch (e) {
      log(e.toString());
      throw Exception('Error === $e');
    }
  }

  Order cocinarDataPedido(Order x) {
    TimeLine timeLineEntity = x.timeLine ?? TimeLine();
    timeLineEntity.marcarPedidoAceptado();
    x.timeLine = timeLineEntity;

    try {
      final delivery = x.jsonDatosDelivery!.isNotEmpty
          ? jsonOneDatosDeliveryFromJson(x.jsonDatosDelivery!)
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

      x.totalPagaRepartidor = total;
      x.propinaRepartidor = propina;
      x.costoDelivery = double.parse(costoEntrega.toString());
    } catch (e) {
      log(e.toString());
      x.jsonDatosDelivery = null;
      x.totalPagaRepartidor = 0;
    }
    return x;
  }

  void cocinarLisPedidosNotificar(List<Order> listOrders) {
    List<ClienteNotificarEntity> listClienteNotificar = [];

    for (Order order in listOrders) {
      final delivery = order.jsonDatosDelivery!.isNotEmpty
          ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
          : JsonDatosDelivery();

      TimeLine timeLineEntity = order.timeLine ?? TimeLine();

      final rowDatos = delivery.pHeader?.arrDatosDelivery;

      final User user = userFromJson(LocalStorage.user);

      if (rowDatos != null) {
        final rowCliente = ClienteNotificarEntity(
          nombre:
              rowDatos.nombre!.isNotEmpty ? rowDatos.nombre!.split(' ')[0] : '',
          telefono: rowDatos.telefono ?? '',
          establecimiento: rowDatos.establecimiento?.nombre ?? '',
          idpedido: order.idpedido ?? 0,
          repartidorNom: user.nombre?.split(' ')[0] ?? '',
          repartidorTelefono: user.telefono ?? '',
          idsede: rowDatos.establecimiento?.idsede ?? '',
          idorg: rowDatos.establecimiento?.idorg ?? '',
          timeLine: timeLineEntity,
        );

        listClienteNotificar.add(rowCliente);
      }
    }

    final socket = SocketProvider();
    socket.emitPedidoAceptado(listClienteNotificar);
  }
}
