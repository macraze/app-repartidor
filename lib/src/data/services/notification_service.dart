import 'dart:convert';

import 'package:app_repartidor/src/data/services/socket_service.dart';

class NotificationSocketsService {
  final SocketClient socket;

  NotificationSocketsService(this.socket);

  void onPedidosPorAceptar(Function(Map<String, dynamic>) callback) {
    socket.on('repartidor-nuevo-pedido', (newOrder) {
      final orderPending = {'pedido_por_aceptar': newOrder[1]};
      print('repartidor-nuevo-pedido $newOrder');
      callback(orderPending);
    });
  }

  void onPedidosPendientesPorAceptar(Function(dynamic) callback) {
    socket.on('repartidor-get-pedido-pendiente-aceptar', (newOrder) {
      print('repartidor-get-pedido-pendiente-aceptar $newOrder');
      callback(newOrder[0]);
    });
  }

  void onPedidoRemovidoByBackEnd(Function(dynamic) callback) {
    socket.on('repartidor-notifica-server-removido-pedido', callback);
    socket.on('repartidor-notifica-server-quita-pedido', callback);
  }

  void onPedidoAsignadoComercio(Function(dynamic) callback) {
    socket.on('set-repartidor-pedido-asigna-comercio', callback);
  }

  void emitPedidoAceptado(List<dynamic> listPedidos) {
    // List<Map<String, dynamic>> lista = listPedidos.cast<Map<String, dynamic>>();
    const data = [
      {
        "nombre": "CRISTINA",
        "telefono": "963258741",
        "establecimiento": "EL ASADOR",
        "idpedido": 23825,
        "repartidor_nom": "CRISTINA",
        "repartidor_telefono": "123123",
        "idsede": "13",
        "idorg": "16",
        "time_line": {
          "hora_acepta_pedido": 1703170390387,
          "hora_pedido_entregado": 1703106442892,
          "llego_al_comercio": false,
          "en_camino_al_cliente": false,
          "mensaje_enviado": null,
          "paso": 1,
          "msj_log": "Pedido aceptado",
          "distanciaMtr": ""
        }
      },
      {
        "nombre": "ARMANDO",
        "telefono": "963258741",
        "establecimiento": "EL ASADOR",
        "idpedido": 23826,
        "repartidor_nom": "CRISTINA",
        "repartidor_telefono": "123123",
        "idsede": "13",
        "idorg": "16",
        "time_line": {
          "hora_acepta_pedido": 1703170390387,
          "hora_pedido_entregado": 1703111627135,
          "llego_al_comercio": false,
          "en_camino_al_cliente": false,
          "mensaje_enviado": {
            "llego_al_comercio": false,
            "en_camino_al_cliente": false
          },
          "paso": 1,
          "msj_log": "Pedido aceptado",
          "distanciaMtr": ""
        }
      }
    ];

    final newData = jsonDecode(jsonEncode(data).toString());

    socket.sendMessage('repartidor-notifica-cliente-acepto-pedido', data);
  }

  void emitTimeLinePedido(List<Map<String, dynamic>> listClienteNotificar) {
    socket.sendMessage(
        'repartidor-notifica-cliente-time-line', listClienteNotificar);
  }

  void emitTerminoEntregarPedidos(int idrepartidor) {
    socket.sendMessage('repartidor-grupo-pedido-finalizado', idrepartidor);
  }
}
