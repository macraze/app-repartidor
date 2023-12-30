import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:app_repartidor/src/data/environment.dart';

class SocketService {
  static SocketService? _instance;
  final io.Socket socket;
  final Map<String, List<Function>> eventListeners = {};
  static final String socketServerUrl = Environment.urlServerSocket;

  SocketService._(String url, Map<String, Object> query)
      : socket = io.io(
            url,
            io.OptionBuilder()
                .setQuery(query)
                .setTransports(['websocket'])
                .enableAutoConnect()
                .build()) {
    socket.on('connect', (_) => onConnect());
    socket.on('disconnect', (_) => onDisconnect());
  }

  static SocketService initSocket({int idrepartidor = 0}) {
    final query = {
      'idrepartidor': idrepartidor,
      'isFromApp': 1,
      'isRepartidor': true,
      'firts_socketid': '',
    };

    _instance ??= SocketService._(socketServerUrl, query);

    return _instance!;
  }

  static SocketService? getInstance() => _instance;

  void onConnect() {
    log('Socket Connected');
  }

  void onDisconnect() {
    disconnect();
    log('Socket Disconnected');
  }

  void sendMessage(String message, dynamic payload) {
    socket.emit(message, payload);
  }

  void disconnect() {
    socket.disconnect();
    _instance = null;
  }

  bool isConnected() => socket.connected;

  void on(String event, dynamic callback) {
    eventListeners[event] ??= [];
    eventListeners[event]!.add(callback);
    socket.on(event, callback);
  }

  void off(String event, dynamic callback) {
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
