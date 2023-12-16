// To parse this JSON data, do
//
//     final orderPendingLocalResponse = orderAssignedLocalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_repartidor/src/domain/models/models.dart';

OrderPendingLocalResponse orderPendingLocalResponseFromJson(String str) =>
    OrderPendingLocalResponse.fromJson(json.decode(str));

String orderPendingLocalResponseToJson(OrderPendingLocalResponse data) =>
    json.encode(data.toJson());

class OrderPendingLocalResponse {
  List<Order>? data;
  bool? success;

  OrderPendingLocalResponse({
    this.data,
    this.success,
  });

  factory OrderPendingLocalResponse.fromJson(Map<String, dynamic> json) =>
      OrderPendingLocalResponse(
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
