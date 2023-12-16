import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  //Variable para guardar el status Online del repartidor global
  bool _switchValue = LocalStorage.online;
  bool get switchValue => _switchValue;
  set switchValue(bool value) {
    LocalStorage.online = value;
    _switchValue = value;
    notifyListeners();
  }

  //Variable para mostrar la carga al actualizar el status Online del repartidor global
  bool _isLoadingOnline = false;
  bool get isLoadingOnline => _isLoadingOnline;
  set isLoadingOnline(bool value) {
    _isLoadingOnline = value;
    notifyListeners();
  }

  //Key para trabajar el monto y el switch del formulario para el repartidor global
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variable para guardar el monto con que se inicia un repartidor global
  int mount = 0;

  //Funcion para validar el formulario del repartidor global
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //Funcion para actualizar el status online del repartidor global
  Future<String?> connectOrderProvider(
      {required int idRepartidor,
      required int mount,
      required int isOnline}) async {
    isLoadingOnline = true;
    OrderService service = OrderService();
    try {
      final response = await service.postConnectOrderService(
          idRepartidor: idRepartidor, mount: mount, isOnline: isOnline);
      if (response != null) {
        return 'Hubo un inconveniente al actualizar el status del repartidor, inténtelo de nuevo o más tarde por favor: $response';
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoadingOnline = false;
      notifyListeners();
    }
  }

  // Lista de pedidos pendientes de entrega del repartidor local
  late List<Order> listOrdersPendingDeliveryLocal = [];

  //Variable para mostrar la carga al listar pedidos pendientes de entrega del repartidor local
  bool _isLoadingListOrdersPendingDeliveryLocal = false;
  bool get isLoadingListOrdersPendingDeliveryLocal =>
      _isLoadingListOrdersPendingDeliveryLocal;
  set isLoadingListOrdersPendingDeliveryLocal(bool value) {
    _isLoadingListOrdersPendingDeliveryLocal = value;
    notifyListeners();
  }

  //Error para mostrar al listar pedidos pendientes de entrega del repartidor local
  late String errorListOrdersPendingDeliveryLocal = '';

  //Logica para mostrar la lista de pedidos pendientes de entrega del repartidor local
  bool _showListOrdersPendingDeliveryLocal = false;
  bool get showListOrdersPendingDeliveryLocal =>
      _showListOrdersPendingDeliveryLocal;
  void toggleVisibilityListOrdersPendingDeliveryLocal() {
    _showListOrdersPendingDeliveryLocal = !_showListOrdersPendingDeliveryLocal;
    notifyListeners();
  }

  // Función que trae la lista de pedidos pendientes de entrega del repartidor local
  Future<List<Order>> getListOrdersPendingDeliveryLocalProvider() async {
    isLoadingListOrdersPendingDeliveryLocal = true;
    OrderService service = OrderService();
    try {
      final response = await service.getListOrdersPendingDeliveryLocalService();
      listOrdersPendingDeliveryLocal = response;
      errorListOrdersPendingDeliveryLocal = '';
    } catch (e) {
      listOrdersPendingDeliveryLocal = [];
      errorListOrdersPendingDeliveryLocal =
          'Hubo un inconveniente al cargar la lista de pedidos del repartidor local, inténtelo de nuevo más tarde por favor: $e';
    } finally {
      isLoadingListOrdersPendingDeliveryLocal = false;
    }
    notifyListeners();
    return listOrdersPendingDeliveryLocal;
  }

  // Variable que guardará la lista de ids seleccionados de los pedidos pendientes de entrega del repartidor local
  List<String> _selectedListOrdersPendingDeliveryLocal = [];

  List<String> get selectedOrdersAssignedLocal =>
      _selectedListOrdersPendingDeliveryLocal;

  set selectedOrdersAssignedLocal(List<String> value) {
    _selectedListOrdersPendingDeliveryLocal = value;
    notifyListeners();
  }

  void toggleSelectionOrderIdPendingDeliveryLocal(String order) {
    if (_selectedListOrdersPendingDeliveryLocal.contains(order)) {
      _selectedListOrdersPendingDeliveryLocal.remove(order);
    } else {
      _selectedListOrdersPendingDeliveryLocal.add(order);
    }
    notifyListeners();
  }

  //Funcion para aceptar la lista de pedidos pendientes de entrega del repartidor local
  Future<String?> acceptListOrdersByIdsProvider({required String ids}) async {
    isLoadingAcceptListOrdersByIds = true;
    OrderService service = OrderService();
    try {
      final response = await service.postAcceptListOrdersByIdsService(ids: ids);
      if (response != null) {
        return 'Hubo un inconveniente al enviar la lista de pedidos del repartidor local, inténtelo de nuevo o más tarde por favor: $response';
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoadingAcceptListOrdersByIds = false;
      notifyListeners();
    }
  }

  //Variable para mostrar la carga al aceptar la lista de pedidos pendientes de entrega del repartidor local
  bool _isLoadingAcceptListOrdersByIds = false;
  bool get isLoadingAcceptListOrdersByIds => _isLoadingAcceptListOrdersByIds;
  set isLoadingAcceptListOrdersByIds(bool value) {
    _isLoadingAcceptListOrdersByIds = value;
    notifyListeners();
  }

  // Función que trae la lista de pedidos aceptados por ids del repartidor local
  Future<List<Order>> getListOrdersAcceptedByIdsProvider(
      {required String ids}) async {
    isLoadingListOrdersAcceptedByIds = true;
    OrderService service = OrderService();
    try {
      final response =
          await service.getListOrdersAcceptedByIdsService(ids: ids);
      listOrdersAcceptedByIds = response;
      errorListOrdersAcceptedByIds = '';
    } catch (e) {
      listOrdersAcceptedByIds = [];
      errorListOrdersAcceptedByIds =
          'Hubo un inconveniente al cargar la lista de pedidos del repartidor local, inténtelo de nuevo más tarde por favor: $e';
    } finally {
      isLoadingListOrdersAcceptedByIds = false;
    }
    notifyListeners();
    return listOrdersAcceptedByIds;
  }

  // Lista de pedidos pendientes de entrega del repartidor local
  late List<Order> listOrdersAcceptedByIds = [];

  //Variable para mostrar la carga al listar pedidos pendientes de entrega del repartidor local
  bool _isLoadingListOrdersAcceptedByIds = false;
  bool get isLoadingListOrdersAcceptedByIds =>
      _isLoadingListOrdersAcceptedByIds;
  set isLoadingListOrdersAcceptedByIds(bool value) {
    _isLoadingListOrdersAcceptedByIds = value;
    notifyListeners();
  }

  //Error para mostrar al listar pedidos pendientes de entrega del repartidor local
  late String errorListOrdersAcceptedByIds = '';

  //Variable que almacena el pedido seleccionado para mostrar su detalle en una pantalla
  Order _orderDetailSelected = Order();
  Order get orderDetailSelected => _orderDetailSelected;
  set orderDetailSelected(Order value) {
    _orderDetailSelected = value;
    notifyListeners();
  }
}
