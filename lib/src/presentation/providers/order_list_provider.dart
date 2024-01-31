import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:flutter/material.dart';

class OrderListProvider extends ChangeNotifier {
  List<Order> get ordersAccepted {
    String jsonString = LocalStorage.pedidosAceptados;
    return orderAcceptedLocalFromJson(jsonString);
  }

  set ordersAccepted(List<Order> newOrders) {
    String jsonString = orderAcceptedLocalToJson(newOrders);
    LocalStorage.pedidosAceptados = jsonString;
    notifyListeners();
  }
}
