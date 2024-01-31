import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class OrderDetailProvider extends ChangeNotifier {
  //Variable que almacena el pedido seleccionado para mostrar su detalle en una pantalla
  Order _orderDetailSelected = Order();
  Order get orderDetailSelected => _orderDetailSelected;
  set orderDetailSelected(Order value) {
    _orderDetailSelected = value;
    notifyListeners();
  }

  //Variable para mostrar la carga al entregar un pedido
  bool _isLoadingOrderDeliveredFinish = false;
  bool get isLoadingOrderDeliveredFinish => _isLoadingOrderDeliveredFinish;
  set isLoadingOrderDeliveredFinish(bool value) {
    _isLoadingOrderDeliveredFinish = value;
    notifyListeners();
  }

  //Funcion para entregar un pedido
  Future<String?> updateToPedidoEntregado() async {
    isLoadingOrderDeliveredFinish = true;
    OrderService service = OrderService();
    try {
      final response =
          await service.updateToPedidoEntregado(order: orderDetailSelected);
      if (response != null) {
        return 'Hubo un inconveniente al entregar un pedido, inténtelo de nuevo o más tarde por favor: $response';
      } else {
        orderDetailSelected.pwaEstado = 'E';
        orderDetailSelected.estado = 2;
        return null;
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoadingOrderDeliveredFinish = false;
      notifyListeners();
    }
  }
}
