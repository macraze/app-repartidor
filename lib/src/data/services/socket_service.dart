import 'dart:developer';

import 'package:app_repartidor/src/data/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  static SocketClient? _instance;
  final io.Socket socket;
  final Map<String, List<Function>> eventListeners = {};
  static final String socketServerUrl = Environment.urlServerSocket;

  SocketClient._(String url, dynamic query)
      : socket = io.io(
            url,
            io.OptionBuilder()
                .setQuery(query)
                .setTransports(['websocket'])
                .enableAutoConnect()
                .build()) {
    socket.on('connect', (_) => connect());
    socket.on('disconnect', (_) => onDisconnect());
  }

  static SocketClient initSocket({int idrepartidor = 0}) {
    final query = {
      'idrepartidor': idrepartidor,
      'isFromApp': 1,
      'isRepartidor': true,
      'firts_socketid': '',
    };

    _instance ??= SocketClient._(socketServerUrl, query);

    return _instance!;
  }

  static SocketClient? getInstance() => _instance;

  void onConnect() {
    log('Connected to Socket');
  }

  void onDisconnect() {
    log('Disconnected from Socket');
  }

  void sendMessage(String message, dynamic payload) {
    socket.emit(message, payload);
  }

  void disconnect() {
    socket.disconnect();
    _instance = null;
  }

  bool isConnected() => socket.connected;

  void connect() {
    log('Connected to Socket');
    socket.connect();
  }

  void on(String event, Function(dynamic) callback) {
    eventListeners[event] ??= [];
    eventListeners[event]!.add(callback);
    socket.on(event, callback);
  }

  void off(String event, Function(dynamic) callback) {
    final listeners = eventListeners[event];
    if (listeners != null) {
      final index = listeners.indexOf(callback);
      if (index != -1) {
        listeners.removeAt(index);
        socket.off(event, callback);
      }
    }
  }
}
