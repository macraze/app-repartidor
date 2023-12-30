import 'dart:convert';
import 'package:app_repartidor/src/domain/models/models.dart';

List<ClienteNotificarEntity> clienteNotificarFromJson(String str) =>
    List<ClienteNotificarEntity>.from(
        json.decode(str).map((x) => ClienteNotificarEntity.fromJson(x)));

String clienteNotificarToJson(List<ClienteNotificarEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClienteNotificarEntity {
  String? nombre;
  String? telefono;
  String? establecimiento;
  int? idpedido;
  String? repartidorNom;
  String? repartidorTelefono;
  dynamic idsede;
  dynamic idorg;
  TimeLine? timeLine;

  ClienteNotificarEntity({
    this.nombre,
    this.telefono,
    this.establecimiento,
    this.idpedido,
    this.repartidorNom,
    this.repartidorTelefono,
    this.idsede,
    this.idorg,
    this.timeLine,
  });

  factory ClienteNotificarEntity.fromJson(Map<String, dynamic> json) =>
      ClienteNotificarEntity(
        nombre: json['nombre'] ?? '',
        telefono: json['telefono'] ?? '',
        establecimiento: json['establecimiento'] ?? '',
        idpedido: json['idpedido'] ?? 0,
        repartidorNom: json['repartidor_nom'] ?? '',
        repartidorTelefono: json['repartidor_telefono'] ?? '',
        idsede: json['idsede'] ?? '',
        idorg: json['idorg'] ?? '',
        timeLine: TimeLine.fromJson(json['time_line']),
      );

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'telefono': telefono,
      'establecimiento': establecimiento,
      'idpedido': idpedido,
      'repartidor_nom': repartidorNom,
      'repartidor_telefono': repartidorTelefono,
      'idsede': idsede,
      'idorg': idorg,
      'time_line': timeLine?.toJson(),
    };
  }
}
