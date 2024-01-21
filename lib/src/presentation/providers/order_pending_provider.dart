import 'dart:async';
import 'dart:convert';

import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class OrderPendingProvider extends ChangeNotifier {
  double _progress = 0;
  double get progress => _progress;
  Timer? _timer;

  //Variable para mostrar la carga al actualizar pedidos a vacío
  bool _isLoadingNullOrdersToAccept = false;
  bool get isLoadingNullOrdersToAccept => _isLoadingNullOrdersToAccept;
  set isLoadingNullOrdersToAccept(bool value) {
    _isLoadingNullOrdersToAccept = value;
    notifyListeners();
  }

  void initPage({OrdersToAccept? order}) {
    if (order != null) {
      // emitSoundNotification(); Agregar el sonido
      startProgress();
    }
  }

  void startProgress() {
    _progress = 0;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_progress >= 1) {
        cancelProgress();
      } else {
        _progress += 1 / 1200; // Ajusta según la duración deseada
        notifyListeners();
      }
    });
  }

  void cancelProgress() {
    _timer?.cancel();
    _progress = 0;
    notifyListeners();
  }

  //Funcion para actualizar la lista de pedidos a vacío
  Future<String?> setNullPedidosPorAceptar() async {
    isLoadingNullOrdersToAccept = true;
    OrderService service = OrderService();
    try {
      final response = await service.postSetNullPedidosPorAceptar();
      if (response != null) {
        return 'Hubo un inconveniente al actualizar la lista a vacío, inténtelo de nuevo o más tarde por favor: $response';
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoadingNullOrdersToAccept = false;
      notifyListeners();
    }
  }

  List<int> getPedidosAceptados() {
    final pedidosAceptadosString = LocalStorage.pedidosAceptados;
    return pedidosAceptadosString.isNotEmpty
        ? List<int>.from(json.decode(pedidosAceptadosString))
        : [];
  }

  List<int> getIdsPedidosLocalStorage() {
    final listPedidos = getPedidosAceptados();
    return listPedidos.map((pedido) => pedido).toList();
  }

  List<int> getIdsPedidosNoLocalStorage(List<int> listPedidos) {
    final listPedidosLocalStorage = getIdsPedidosLocalStorage();
    return listPedidos
        .where((id) => !listPedidosLocalStorage.contains(id))
        .toList();
  }
}
