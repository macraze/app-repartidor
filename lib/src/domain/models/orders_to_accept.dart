// To parse this JSON data, do
//
//     final ordersToAccept = ordersToAcceptFromJson(jsonString);

import 'dart:convert';

OrdersToAccept ordersToAcceptFromJson(String str) =>
    OrdersToAccept.fromJson(json.decode(str));

String ordersToAcceptToJson(OrdersToAccept data) => json.encode(data.toJson());

class OrdersToAccept {
  PedidoPorAceptar? pedidoPorAceptar;
  int? solicitaLiberarPedido;
  int? pedidoPasoVa;
  String? socketid;
  dynamic keySuscripcionPush;

  OrdersToAccept({
    this.pedidoPorAceptar,
    this.solicitaLiberarPedido,
    this.pedidoPasoVa,
    this.socketid,
    this.keySuscripcionPush,
  });

  factory OrdersToAccept.fromJson(Map<String, dynamic> json) => OrdersToAccept(
        pedidoPorAceptar: json["pedido_por_aceptar"] == null
            ? null
            : PedidoPorAceptar.fromJson(json["pedido_por_aceptar"]),
        solicitaLiberarPedido: json["solicita_liberar_pedido"],
        pedidoPasoVa: json["pedido_paso_va"],
        socketid: json["socketid"],
        keySuscripcionPush: json["key_suscripcion_push"],
      );

  Map<String, dynamic> toJson() => {
        "pedido_por_aceptar": pedidoPorAceptar?.toJson(),
        "solicita_liberar_pedido": solicitaLiberarPedido,
        "pedido_paso_va": pedidoPasoVa,
        "socketid": socketid,
        "key_suscripcion_push": keySuscripcionPush,
      };
}

class PedidoPorAceptar {
  List<int>? pedidos;
  int? cantidadPedidosAceptados;
  int? cantidadEntregados;
  int? importeAcumula;
  int? importePagar;
  int? lastIdRepartidorReasigno;
  int? idsede;
  int? numReasignaciones;
  SedeCoordenadas? sedeCoordenadas;

  PedidoPorAceptar({
    this.pedidos,
    this.cantidadPedidosAceptados,
    this.cantidadEntregados,
    this.importeAcumula,
    this.importePagar,
    this.lastIdRepartidorReasigno,
    this.idsede,
    this.numReasignaciones,
    this.sedeCoordenadas,
  });

  factory PedidoPorAceptar.fromJson(Map<String, dynamic> json) =>
      PedidoPorAceptar(
        pedidos: json["pedidos"] == null
            ? []
            : List<int>.from(json["pedidos"]!.map((x) => x)),
        cantidadPedidosAceptados: json["cantidad_pedidos_aceptados"],
        cantidadEntregados: json["cantidad_entregados"],
        importeAcumula: json["importe_acumula"],
        importePagar: json["importe_pagar"],
        lastIdRepartidorReasigno: json["last_id_repartidor_reasigno"],
        idsede: json["idsede"],
        numReasignaciones: json["num_reasignaciones"],
        sedeCoordenadas: json["sede_coordenadas"] == null
            ? null
            : SedeCoordenadas.fromJson(json["sede_coordenadas"]),
      );

  Map<String, dynamic> toJson() => {
        "pedidos":
            pedidos == null ? [] : List<dynamic>.from(pedidos!.map((x) => x)),
        "cantidad_pedidos_aceptados": cantidadPedidosAceptados,
        "cantidad_entregados": cantidadEntregados,
        "importe_acumula": importeAcumula,
        "importe_pagar": importePagar,
        "last_id_repartidor_reasigno": lastIdRepartidorReasigno,
        "idsede": idsede,
        "num_reasignaciones": numReasignaciones,
        "sede_coordenadas": sedeCoordenadas?.toJson(),
      };
}

class SedeCoordenadas {
  dynamic latitude;
  dynamic longitude;

  SedeCoordenadas({
    this.latitude,
    this.longitude,
  });

  factory SedeCoordenadas.fromJson(Map<String, dynamic> json) =>
      SedeCoordenadas(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
