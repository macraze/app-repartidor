// To parse this JSON data, do
//
//     final ordersAcceptedResponse = ordersAcceptedResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_repartidor/src/domain/models/models.dart';

OrdersAcceptedResponse ordersAcceptedResponseFromJson(String str) =>
    OrdersAcceptedResponse.fromJson(json.decode(str));

String ordersAcceptedResponseToJson(OrdersAcceptedResponse data) =>
    json.encode(data.toJson());

class OrdersAcceptedResponse {
  List<Order>? data;
  bool? success;

  OrdersAcceptedResponse({
    this.data,
    this.success,
  });

  factory OrdersAcceptedResponse.fromJson(Map<String, dynamic> json) =>
      OrdersAcceptedResponse(
        data: json["data"] == null
            ? []
            : List<Order>.from(
                json["data"]!.map((x) => Order.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}
