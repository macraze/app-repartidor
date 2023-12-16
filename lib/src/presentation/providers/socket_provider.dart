import 'dart:developer';
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

  late io.Socket _socket;
  io.Socket get socket => _socket;

  static final String _urlSocket = Environment.urlServerSocket;

  SocketProvider() {
    _initConfig();
  }

  void _initConfig() {
    final User user = userFromJson(LocalStorage.user);

    final query = {
      'idrepartidor': user.idrepartidor,
      'isFromApp': 1,
      'isRepartidor': true,
      'firts_socketid': ''
    };

    _socket = io.io(
      _urlSocket,
      io.OptionBuilder()
          .setQuery(query)
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      log('connect');
      serverStatus = ServerStatus.online;
    });

    // _socket.on('repartidor-get-pedido-pendiente-aceptar', (data) {
    //   log('repartidor-get-pedido-pendiente-aceptar');
    //   log('Evento recibido: $data');
    // });

    // _socket.on('set-repartidor-pedido-asigna-comercio', (data) {
    //   log('set-repartidor-pedido-asigna-comercio');
    //   log('Evento recibido: $data');
    // });

    _socket.onDisconnect((_) {
      log('disconnect');
      serverStatus = ServerStatus.offline;
    });
  }

  void emitPedidoAceptado(List<ClienteNotificarEntity> listPedidos) {
    final list = clienteNotificarToJson(listPedidos);
    _socket.emit('repartidor-notifica-cliente-acepto-pedido', list);
  }
}
