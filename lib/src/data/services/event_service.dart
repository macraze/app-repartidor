import 'dart:developer';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/domain/models/order_model.dart';
import 'package:app_repartidor/src/data/services/socket_service.dart';

class EventService {
  late SocketService socket;

  EventService(SocketService socketClient) {
    socket = socketClient;
  }

  void onPedidosPorAceptar(Function(Map<String, dynamic>) callback) {
    log('ON repartidor-nuevo-pedido');
    socket.on('repartidor-nuevo-pedido', (newOrder) {
      final orderPending = {'pedido_por_aceptar': newOrder[1]};
      callback(orderPending);
    });
  }

  void onPedidosPendientesPorAceptar(Function(dynamic) callback) {
    log('ON repartidor-get-pedido-pendiente-aceptar');
    socket.on('repartidor-get-pedido-pendiente-aceptar', (newOrder) {
      callback(newOrder[0]);
    });
  }

  void onPedidoRemovidoByBackEnd(Function(dynamic) callback) {
    log('ON repartidor-notifica-server-removido-pedido');
    socket.on('repartidor-notifica-server-removido-pedido', callback);
    log('ON repartidor-notifica-server-quita-pedido');
    socket.on('repartidor-notifica-server-quita-pedido', callback);
  }

  void onPedidoAsignadoComercio(Function(dynamic) callback) {
    log('ON set-repartidor-pedido-asigna-comercio');
    socket.on('set-repartidor-pedido-asigna-comercio', callback);
  }

  void emitPedidoAceptado(String listPedidos) {
    log('EMIT repartidor-notifica-cliente-acepto-pedido');
    socket.sendMessage(
        'repartidor-notifica-cliente-acepto-pedido', listPedidos);
  }

  void emitTimeLinePedido(List<Map<String, dynamic>> listClienteNotificar) {
    log('EMIT repartidor-notifica-cliente-time-line');
    socket.sendMessage(
        'repartidor-notifica-cliente-time-line', listClienteNotificar);
  }

  void emitTerminoEntregarPedidos(int idrepartidor) {
    log('EMIT repartidor-grupo-pedido-finalizado');
    socket.sendMessage('repartidor-grupo-pedido-finalizado', idrepartidor);
  }

  void emitUpdatePedidoEntregado(Order order, bool isRepartidorPropio) {
    if (isRepartidorPropio) {
      log('EMIT repartidor-propio-notifica-fin-pedido');
      socket.sendMessage('repartidor-propio-notifica-fin-pedido', order);
    } else {
      log('EMIT repartidor-notifica-fin-one-pedido');
      socket.sendMessage('repartidor-notifica-fin-one-pedido', order);
    }
  }
}
