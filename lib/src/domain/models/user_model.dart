// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int idrepartidor;
  String? nombre;
  String? apellido;
  String? ciudad;
  String? usuario;
  String? pass;
  int? idsedeSuscrito;
  String? telefono;
  int? pedidosAsignados;

  User({
    required this.idrepartidor,
    this.nombre,
    this.apellido,
    this.ciudad,
    this.usuario,
    this.pass,
    this.idsedeSuscrito,
    this.telefono,
    this.pedidosAsignados,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idrepartidor: json["idrepartidor"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        ciudad: json["ciudad"],
        usuario: json["usuario"],
        pass: json["pass"],
        idsedeSuscrito: json["idsede_suscrito"],
        telefono: json["telefono"],
        pedidosAsignados: json["pedidos_asignados"],
      );

  Map<String, dynamic> toJson() => {
        "idrepartidor": idrepartidor,
        "nombre": nombre,
        "apellido": apellido,
        "ciudad": ciudad,
        "usuario": usuario,
        "pass": pass,
        "idsede_suscrito": idsedeSuscrito,
        "telefono": telefono,
        "pedidos_asignados": pedidosAsignados,
      };
}
