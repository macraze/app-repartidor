import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/entities/entities.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';

enum ServerStatus { online, offline, connecting }

class SocketProvider extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  ServerStatus get serverStatus => _serverStatus;
  set serverStatus(ServerStatus value) {
    _serverStatus = value;
    notifyListeners();
  }

  void updateToPedidoEntregado({required Order order}) {
    try {
      bool isRepartidorPropio = UserProvider().isRepartidorPropio;

      const four = 4;
      const two = 2;

      if (isRepartidorPropio) {
        order.estado = four;
        order.pasoVa = four;
        order.pwaDeliveryStatus = four.toString();
      } else {
        order.estado = two;
      }

      final notificationServices = EventService(SocketService.getInstance()!);

      notificationServices.emitUpdatePedidoEntregado(order, isRepartidorPropio);
    } catch (e, stackTrace) {
      log('Error al enviar datos al servidor: $e\n$stackTrace');
    }
  }

  void cocinarLisPedidosNotificar({required List<Order> listOrders}) {
    try {
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
            nombre: rowDatos.nombre!.isNotEmpty
                ? rowDatos.nombre!.split(' ')[0]
                : '',
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

      final list = clienteNotificarToJson(listClienteNotificar);
      final newList = json.encode(list);

      final notificationServices = EventService(SocketService.getInstance()!);
      notificationServices.emitPedidoAceptado(newList);
    } catch (e, stackTrace) {
      log('Error al enviar datos al servidor: $e\n$stackTrace');
    }
  }
}
