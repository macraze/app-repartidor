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
    socket.on('connect_error', (data) => log(' connect_error === $data'));
    socket.on('connect_timeout', (data) => log(' connect_timeout === $data'));
    socket.on('connecting', (data) => log(' connecting === $data'));
    socket.on('error', (data) => log(' error === $data'));
    socket.on('reconnect', (data) => log(' reconnect === $data'));
    socket.on(
        'reconnect_attempt', (data) => log(' reconnect_attempt === $data'));
    socket.on(
        'reconnect_failed', (data) => log(' reconnect_failed === $data'));
    socket.on('reconnect_error', (data) => log(' reconnect_error === $data'));
    socket.on('reconnecting', (data) => log(' reconnecting === $data'));
    socket.on('ping', (data) => log(' ping === $data'));
    socket.on('pong', (data) => log(' pong === $data'));
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
