import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/data/services/event_service.dart';
import 'package:app_repartidor/src/data/services/socket_service.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _listOrdersAcepts = [];
  List<Order> get listOrdersAcepts => _listOrdersAcepts;
  set listOrdersAcepts(List<Order> value) {
    _listOrdersAcepts = value;
    notifyListeners();
  }

  bool get hasAcceptedOrdersStored {
    return LocalStorage.pedidosAceptados.isNotEmpty;
  }

  late OrdersToAccept? _orderPending;
  OrdersToAccept? get orderPending => _orderPending;
  set orderPending(OrdersToAccept? value) {
    _orderPending = value;
    notifyListeners();
  }

  bool _existOrderPending = false;
  bool get existOrderPending => _existOrderPending;
  set existOrderPending(bool value) {
    _existOrderPending = value;
    notifyListeners();
  }

  void setupSocketListeners() {
    final User user = LocalStorage.user.isNotEmpty
        ? userFromJson(LocalStorage.user)
        : User(idrepartidor: 0);

    SocketService socketService =
        SocketService.initSocket(idrepartidor: user.idrepartidor);

    final notificationServices = EventService(socketService);

    notificationServices.onPedidosPorAceptar((data) {
      orderPending = OrdersToAccept.fromJson(data);
      existOrderPending = true;
    });

    notificationServices.onPedidosPendientesPorAceptar((data) {
      orderPending = OrdersToAccept.fromJson(data);
      if (orderPending?.pedidoPorAceptar != null) {
        existOrderPending = true;
      } else {
        existOrderPending = false;
        orderPending = null;
      }
    });

    // Actualizar el estado cuando un pedido es removido
    notificationServices.onPedidoRemovidoByBackEnd((data) {
      orderPending = null;
      existOrderPending = false;
    });

    notificationServices.onPedidoAsignadoComercio((data) {
      // Call to service pedidoAsignadoComercioOrPacman(), when send data
    });
  }
}
