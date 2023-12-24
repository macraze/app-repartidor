import 'dart:convert';
import 'dart:developer';
import 'package:app_repartidor/src/data/services/notification_service.dart';
import 'package:app_repartidor/src/data/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:app_repartidor/src/data/environment.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/entities/entities.dart';

enum ServerStatus { online, offline, connecting }

class SocketProvider extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  ServerStatus get serverStatus => _serverStatus;
  set serverStatus(ServerStatus value) {
    _serverStatus = value;
    notifyListeners();
  }

  // late io.Socket _socket;
  // io.Socket get socket => _socket;
  // Function get emit => _socket.emit;

  // static final String _urlSocket = Environment.urlServerSocket;

  // void initConfig() {
  //   final User user = LocalStorage.user.isNotEmpty
  //       ? userFromJson(LocalStorage.user)
  //       : User(idrepartidor: 0);

  //   final query = {
  //     'idrepartidor': user.idrepartidor,
  //     'isFromApp': 1,
  //     'isRepartidor': true,
  //   };

  //   _socket = io.io(
  //     _urlSocket,
  //     io.OptionBuilder()
  //         .setQuery(query)
  //         .setTransports(['websocket'])
  //         // .enableAutoConnect()
  //         .disableAutoConnect()
  //         // .enableForceNew()
  //         .build(),
  //   );

  //   _socket.connect();

  //   _socket.onConnect((_) {
  //     log('connect SOCKET');
  //     serverStatus = ServerStatus.online;
  //   });

  //   _socket.onDisconnect((_) {
  //     log('disconnect SOCKET');
  //     serverStatus = ServerStatus.offline;
  //   });

  //   _socket.onConnectError((error) {
  //     log('Error connecting to the server: $error');
  //   });
  // }

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

      final n = jsonDecode(list);

      log('EMIT repartidor-notifica-cliente-acepto-pedido');
      final notificationServices =
          NotificationSocketsService(SocketClient.getInstance()!);
      notificationServices.emitPedidoAceptado(n);

      // _socket.emit('repartidor-notifica-cliente-acepto-pedido', n);
    } catch (e, stackTrace) {
      log('Error al enviar datos al servidor: $e\n$stackTrace');
    }
  }

  void updateToPedidoEntregado({required Order order}) {
    final User user = userFromJson(LocalStorage.user);

    bool isRepartidorPropio = user.idsedeSuscrito == null ? false : true;

    const four = 4;
    const two = 2;

    if (isRepartidorPropio) {
      order.estado = four;
      order.pasoVa = four;
      order.pwaDeliveryStatus = four.toString();
    } else {
      order.estado = two;
    }

    final socketService = SocketClient.getInstance();

    if (isRepartidorPropio) {
      log('EMIT repartidor-propio-notifica-fin-pedido');
      socketService!
          .sendMessage('repartidor-propio-notifica-fin-pedido', order);
    } else {
      log('EMIT repartidor-notifica-fin-one-pedido');
      socketService!.sendMessage('repartidor-notifica-fin-one-pedido', order);
    }
  }
}
