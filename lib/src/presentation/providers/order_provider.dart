import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  bool _switchValue = LocalStorage.online;
  bool get switchValue => _switchValue;
  set switchValue(bool value) {
    LocalStorage.online = value;
    _switchValue = value;
    notifyListeners();
  }

  //Variable para mostrar la carga al actualizar el status Online
  bool _isLoadingOnline = false;
  bool get isLoadingOnline => _isLoadingOnline;
  set isLoadingOnline(bool value) {
    _isLoadingOnline = value;
    notifyListeners();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int mount = 0;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> connectOrder(
      {required int idRepartidor,
      required int mount,
      required int isOnline}) async {
    isLoadingOnline = true;
    OrderService service = OrderService();
    try {
      final resp = await service.postConnectOrder(
          idRepartidor: idRepartidor, mount: mount, isOnline: isOnline);
      if (resp != null) {
        return 'Hubo un inconveniente al actualizar el status del repartidor, inténtelo de nuevo o más tarde por favor.';
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
}
