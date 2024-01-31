import 'dart:convert';

import 'package:app_repartidor/src/domain/models/models.dart';

AssignOrderResponse assignOrderResponseFromJson(String str) =>
    AssignOrderResponse.fromJson(json.decode(str));

class AssignOrderResponse {
  final List<Order> data;
  final bool success;

  AssignOrderResponse({required this.data, required this.success});

  factory AssignOrderResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Order> data = list.map((i) => Order.fromJson(i)).toList();
    return AssignOrderResponse(
      data: data,
      success: json['success'],
    );
  }
}
