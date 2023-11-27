// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_repartidor/src/domain/models/user_model.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  User? usuario;
  String? token;
  bool? success;

  LoginResponse({
    this.usuario,
    this.token,
    this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        usuario:
            json["usuario"] == null ? null : User.fromJson(json["usuario"]),
        token: json["token"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario?.toJson(),
        "token": token,
        "success": success,
      };
}
