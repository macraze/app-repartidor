import 'package:flutter/material.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';

class OrderTempProvider extends ChangeNotifier {
  List<Order> _listOrdersAcepts = [];
  List<Order> get listOrdersAcepts => _listOrdersAcepts;
  set listOrdersAcepts(List<Order> value) {
    _listOrdersAcepts = value;
    notifyListeners();
  }

  late OrdersToAccept? _orderPending;
  OrdersToAccept? get orderPending => _orderPending;
  set orderPending(OrdersToAccept? value) {
    _orderPending = value;
    notifyListeners();
  }

  bool _orderPendingVisible = false;
  bool get orderPendingVisible => _orderPendingVisible;
  set orderPendingVisible(bool value) {
    _orderPendingVisible = value;
    notifyListeners();
  }

  bool _overrideShowCatWaiting = false;

  bool _isShowCatWaiting = false;

  bool get isShowCatWaiting {
    if (_overrideShowCatWaiting) {
      return _isShowCatWaiting;
    }
    loadPedidosAceptados();
    return _listOrdersAcepts.isEmpty && !_orderPendingVisible;
  }

  set isShowCatWaiting(bool value) {
    _overrideShowCatWaiting = true;
    _isShowCatWaiting = value;
    notifyListeners();
  }

  void resetShowCatWaiting() {
    _overrideShowCatWaiting = false;
    notifyListeners();
  }

  bool get isShowOrderPending => _orderPendingVisible;

  Future<void> loadPedidosAceptados() async {
    final String pedidosAceptadosString = LocalStorage.pedidosAceptados;
    if (pedidosAceptadosString.isNotEmpty) {
      _listOrdersAcepts = orderAcceptedLocalFromJson(pedidosAceptadosString);
      resetShowCatWaiting();
    }
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
      resetShowCatWaiting();
      orderPendingVisible = true;
    });

    notificationServices.onPedidosPendientesPorAceptar((data) {
      orderPending = OrdersToAccept.fromJson(data);
      resetShowCatWaiting();
      if (orderPending?.pedidoPorAceptar != null) {
        orderPendingVisible = true;
      } else {
        orderPendingVisible = false;
        orderPending = null;
      }
    });

    // Actualizar el estado cuando un pedido es removido
    notificationServices.onPedidoRemovidoByBackEnd((data) {
      orderPending = null;
      resetShowCatWaiting();
      orderPendingVisible = false;
    });

    notificationServices.onPedidoAsignadoComercio((data) {
      // Call to service pedidoAsignadoComercioOrPacman(), when send data
    });
  }
}
