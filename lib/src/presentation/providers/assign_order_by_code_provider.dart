import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class AssignOrderByCodeProvider extends ChangeNotifier {
  //Logica para mostrar la lista de pedidos pendientes de entrega del repartidor local
  bool _showListOrdersPendingDeliveryLocal = false;
  bool get showListOrdersPendingDeliveryLocal =>
      _showListOrdersPendingDeliveryLocal;
  void toggleVisibilityListOrdersPendingDeliveryLocal() {
    _showListOrdersPendingDeliveryLocal = !_showListOrdersPendingDeliveryLocal;
    notifyListeners();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _orderCode = '';
  String get orderCode => _orderCode;
  set orderCode(String value) {
    _orderCode = value;
    notifyListeners();
  }

  bool _isLoadingOrderCode = false;
  bool get isLoadingOrderCode => _isLoadingOrderCode;
  set isLoadingOrderCode(bool value) {
    _isLoadingOrderCode = value;
    notifyListeners();
  }

  String _responseMessage = '';
  String get responseMessage => _responseMessage;
  set responseMessage(String value) {
    _responseMessage = value;
    notifyListeners();
  }

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  set isSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void updateRptMessage(String message, bool success) {
    responseMessage = message;
    isSuccess = success;
  }

  Future<String?> assignOrderProvider(
      {required int idPedido, required int idRepartidor}) async {
    isLoadingOrderCode = true;
    OrderService service = OrderService();

    try {
      AssignOrderResponse response = await service.postAssignOrderService(
          idRepartidor: idRepartidor, idpedido: idPedido);

      if (!response.success) {
        updateRptMessage('Error: Desconocido', false);
        return 'Error: Desconocido';
      }

      if (_isOrderNonExistent(response)) {
        return _handleNonExistentOrder();
      }

      if (_isOrderAlreadyAssigned(response)) {
        return _handleAlreadyAssignedOrder();
      }

      return _handleSuccessfulAssignment();
    } catch (e) {
      return _handleAssignmentError(e);
    } finally {
      clearForm();
      isLoadingOrderCode = false;
      notifyListeners();
    }
  }

  bool _isOrderNonExistent(AssignOrderResponse apiResponse) {
    return apiResponse.data.isEmpty;
  }

  bool _isOrderAlreadyAssigned(AssignOrderResponse apiResponse) {
    return apiResponse.data[0].idrepartidor != null;
  }

  String? _handleNonExistentOrder() {
    updateRptMessage('El pedido no existe.', false);
    return 'Error: El pedido no existe.';
  }

  String? _handleAlreadyAssignedOrder() {
    updateRptMessage('El pedido ya tiene repartidor asignado.', false);
    return 'Error: El pedido ya tiene repartidor asignado.';
  }

  String? _handleSuccessfulAssignment() {
    updateRptMessage('Pedido asignado correctamente.', true);
    return null;
  }

  String? _handleAssignmentError(Object e) {
    updateRptMessage('Error al asignar el pedido: ${e.toString()}', false);
    return e.toString();
  }

  void clearForm() {
    formKey.currentState?.reset();
    orderCode = '';
    notifyListeners();
  }
}
