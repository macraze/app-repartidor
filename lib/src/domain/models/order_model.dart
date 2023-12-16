// To parse this JSON data, do
//
//     final orderAcceptedLocal = orderAcceptedLocalFromJson(jsonString);

import 'dart:convert';

List<Order> orderAcceptedLocalFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderAcceptedLocalToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Order orderAcceptedLocalOneFromJson(String str) =>
    Order.fromJson(json.decode(str));

String orderAcceptedLocalOneToJson(Order data) => json.encode(data.toJson());

class Order {
  int? idpedido;
  int? idorg;
  int? idsede;
  int? idcliente;
  int? idusuario;
  int? idregistroPago;
  String? fecha;
  String? hora;
  DateTime? fechaHora;
  int? nummesa;
  int? numpedido;
  int? correlativoDia;
  int? reserva;
  String? referencia;
  String? total;
  String? totalR;
  dynamic totalTotal;
  int? soloLlevar;
  int? idtipoConsumo;
  int? idcategoria;
  String? tiempoAtencion;
  dynamic valColorDespachado;
  int? cierre;
  dynamic motivoAnular;
  int? despachado;
  String? subtotalesTachados;
  int? estado;
  String? jsonDatosDelivery;
  int? isFromClientPwa;
  String? pwaDeliveryStatus;
  int? idrepartidor;
  String? pwaEstado;
  int? pwaFacturado;
  int? pwaIsDelivery;
  int? numReasignaciones;
  dynamic lastIdRepartidorReasigno;
  String? pwaDeliveryTiempoAtendido;
  int? flagSolicitaRepartidorPapaya;
  int? flagAbonado;
  String? checkLiquidado;
  String? checkPagado;
  String? checkPagoFecha;
  String? checkPagoRepartidor;
  int? flagPedidoProgramado;
  DateTime? fechaHoraRegistro;
  int? flagCalificado;
  int? confirmarPago;
  int? idpwaPagoTransaction;
  int? idregistraScanQr;
  int? isPrecuenta;
  int? isPrinter;
  int? flagIsCliente;
  int? pwaDeliveryAtendido;
  String? permissionDelete;
  String? descripcion;
  String? titulo;
  int? idimpresora;
  String? habilitadoChatbot;
  TimeLine? timeLine;

  double? _totalPagaRepartidor;
  double? get totalPagaRepartidor => _totalPagaRepartidor;
  set totalPagaRepartidor(double? value) {
    _totalPagaRepartidor = value;
  }

  double? _propinaRepartidor;
  double? get propinaRepartidor => _propinaRepartidor;
  set propinaRepartidor(double? value) {
    _propinaRepartidor = value;
  }

  double? _costoDelivery;
  double? get costoDelivery => _costoDelivery;
  set costoDelivery(double? value) {
    _costoDelivery = value;
  }

  Order({
    this.idpedido,
    this.idorg,
    this.idsede,
    this.idcliente,
    this.idusuario,
    this.idregistroPago,
    this.fecha,
    this.hora,
    this.fechaHora,
    this.nummesa,
    this.numpedido,
    this.correlativoDia,
    this.reserva,
    this.referencia,
    this.total,
    this.totalR,
    this.totalTotal,
    this.soloLlevar,
    this.idtipoConsumo,
    this.idcategoria,
    this.tiempoAtencion,
    this.valColorDespachado,
    this.cierre,
    this.motivoAnular,
    this.despachado,
    this.subtotalesTachados,
    this.estado,
    this.jsonDatosDelivery,
    this.isFromClientPwa,
    this.pwaDeliveryStatus,
    this.idrepartidor,
    this.pwaEstado,
    this.pwaFacturado,
    this.pwaIsDelivery,
    this.numReasignaciones,
    this.lastIdRepartidorReasigno,
    this.pwaDeliveryTiempoAtendido,
    this.flagSolicitaRepartidorPapaya,
    this.flagAbonado,
    this.checkLiquidado,
    this.checkPagado,
    this.checkPagoFecha,
    this.checkPagoRepartidor,
    this.flagPedidoProgramado,
    this.fechaHoraRegistro,
    this.flagCalificado,
    this.confirmarPago,
    this.idpwaPagoTransaction,
    this.idregistraScanQr,
    this.isPrecuenta,
    this.isPrinter,
    this.flagIsCliente,
    this.pwaDeliveryAtendido,
    this.permissionDelete,
    this.descripcion,
    this.titulo,
    this.idimpresora,
    this.habilitadoChatbot,
    this.timeLine,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idpedido: json["idpedido"],
        idorg: json["idorg"],
        idsede: json["idsede"],
        idcliente: json["idcliente"],
        idusuario: json["idusuario"],
        idregistroPago: json["idregistro_pago"],
        fecha: json["fecha"],
        hora: json["hora"],
        fechaHora: json["fecha_hora"] == null
            ? null
            : DateTime.parse(json["fecha_hora"]),
        nummesa: json["nummesa"],
        numpedido: json["numpedido"],
        correlativoDia: json["correlativo_dia"],
        reserva: json["reserva"],
        referencia: json["referencia"],
        total: json["total"],
        totalR: json["total_r"],
        totalTotal: json["total_total"],
        soloLlevar: json["solo_llevar"],
        idtipoConsumo: json["idtipo_consumo"],
        idcategoria: json["idcategoria"],
        tiempoAtencion: json["tiempo_atencion"],
        valColorDespachado: json["val_color_despachado"],
        cierre: json["cierre"],
        motivoAnular: json["motivo_anular"],
        despachado: json["despachado"],
        subtotalesTachados: json["subtotales_tachados"],
        estado: json["estado"],
        jsonDatosDelivery: json["json_datos_delivery"],
        isFromClientPwa: json["is_from_client_pwa"],
        pwaDeliveryStatus: json["pwa_delivery_status"],
        idrepartidor: json["idrepartidor"],
        pwaEstado: json["pwa_estado"],
        pwaFacturado: json["pwa_facturado"],
        pwaIsDelivery: json["pwa_is_delivery"],
        numReasignaciones: json["num_reasignaciones"],
        lastIdRepartidorReasigno: json["last_id_repartidor_reasigno"],
        pwaDeliveryTiempoAtendido: json["pwa_delivery_tiempo_atendido"],
        flagSolicitaRepartidorPapaya: json["flag_solicita_repartidor_papaya"],
        flagAbonado: json["flag_abonado"],
        checkLiquidado: json["check_liquidado"],
        checkPagado: json["check_pagado"],
        checkPagoFecha: json["check_pago_fecha"],
        checkPagoRepartidor: json["check_pago_repartidor"],
        flagPedidoProgramado: json["flag_pedido_programado"],
        fechaHoraRegistro: json["fecha_hora_registro"] == null
            ? null
            : DateTime.parse(json["fecha_hora_registro"]),
        flagCalificado: json["flag_calificado"],
        confirmarPago: json["confirmar_pago"],
        idpwaPagoTransaction: json["idpwa_pago_transaction"],
        idregistraScanQr: json["idregistra_scan_qr"],
        isPrecuenta: json["is_precuenta"],
        isPrinter: json["is_printer"],
        flagIsCliente: json["flag_is_cliente"],
        pwaDeliveryAtendido: json["pwa_delivery_atendido"],
        permissionDelete: json["permission_delete"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        idimpresora: json["idimpresora"] == null ? null : json["idimpresora"],
        habilitadoChatbot: json["habilitado_chatbot"] == null
            ? null
            : json["habilitado_chatbot"],
        timeLine: json["time_line"] == null
            ? null
            : TimeLine.fromJson(json["time_line"]),
      );

  Map<String, dynamic> toJson() => {
        "idpedido": idpedido,
        "idorg": idorg,
        "idsede": idsede,
        "idcliente": idcliente,
        "idusuario": idusuario,
        "idregistro_pago": idregistroPago,
        "fecha": fecha,
        "hora": hora,
        "fecha_hora": fechaHora?.toIso8601String(),
        "nummesa": nummesa,
        "numpedido": numpedido,
        "correlativo_dia": correlativoDia,
        "reserva": reserva,
        "referencia": referencia,
        "total": total,
        "total_r": totalR,
        "total_total": totalTotal,
        "solo_llevar": soloLlevar,
        "idtipo_consumo": idtipoConsumo,
        "idcategoria": idcategoria,
        "tiempo_atencion": tiempoAtencion,
        "val_color_despachado": valColorDespachado,
        "cierre": cierre,
        "motivo_anular": motivoAnular,
        "despachado": despachado,
        "subtotales_tachados": subtotalesTachados,
        "estado": estado,
        "json_datos_delivery": jsonDatosDelivery,
        "is_from_client_pwa": isFromClientPwa,
        "pwa_delivery_status": pwaDeliveryStatus,
        "idrepartidor": idrepartidor,
        "pwa_estado": pwaEstado,
        "pwa_facturado": pwaFacturado,
        "pwa_is_delivery": pwaIsDelivery,
        "num_reasignaciones": numReasignaciones,
        "last_id_repartidor_reasigno": lastIdRepartidorReasigno,
        "pwa_delivery_tiempo_atendido": pwaDeliveryTiempoAtendido,
        "flag_solicita_repartidor_papaya": flagSolicitaRepartidorPapaya,
        "flag_abonado": flagAbonado,
        "check_liquidado": checkLiquidado,
        "check_pagado": checkPagado,
        "check_pago_fecha": checkPagoFecha,
        "check_pago_repartidor": checkPagoRepartidor,
        "flag_pedido_programado": flagPedidoProgramado,
        "fecha_hora_registro": fechaHoraRegistro?.toIso8601String(),
        "flag_calificado": flagCalificado,
        "confirmar_pago": confirmarPago,
        "idpwa_pago_transaction": idpwaPagoTransaction,
        "idregistra_scan_qr": idregistraScanQr,
        "is_precuenta": isPrecuenta,
        "is_printer": isPrinter,
        "flag_is_cliente": flagIsCliente,
        "pwa_delivery_atendido": pwaDeliveryAtendido,
        "permission_delete": permissionDelete,
        "descripcion": descripcion,
        "titulo": titulo,
        "idimpresora": idimpresora,
        "habilitado_chatbot": habilitadoChatbot,
        "time_line": timeLine?.toJson(),
      };
}

class TimeLine {
  int? paso;
  String? msjLog;
  String? distanciaMtr;
  MensajeEnviado? mensajeEnviado;
  bool? llegoAlComercio;
  int? horaAceptaPedido;
  bool? enCaminoAlCliente;
  int? horaPedidoEntregado;

  TimeLine({
    this.paso = 0,
    this.msjLog = '',
    this.distanciaMtr = '',
    this.mensajeEnviado,
    this.llegoAlComercio = false,
    this.horaAceptaPedido = 0,
    this.enCaminoAlCliente = false,
    this.horaPedidoEntregado = 0,
  });

  factory TimeLine.fromJson(Map<String, dynamic> json) => TimeLine(
        // es igual a decir setData()
        paso: json["paso"],
        msjLog: json["msj_log"],
        distanciaMtr: json["distanciaMtr"],
        mensajeEnviado: json["mensaje_enviado"] == null
            ? null
            : MensajeEnviado.fromJson(json["mensaje_enviado"]),
        llegoAlComercio: json["llego_al_comercio"],
        horaAceptaPedido: json["hora_acepta_pedido"],
        enCaminoAlCliente: json["en_camino_al_cliente"],
        horaPedidoEntregado: json["hora_pedido_entregado"],
      );

  Map<String, dynamic> toJson() => {
        // es igual a decir getData()
        "paso": paso,
        "msj_log": msjLog,
        "distanciaMtr": distanciaMtr,
        "mensaje_enviado": mensajeEnviado?.toJson(),
        "llego_al_comercio": llegoAlComercio,
        "hora_acepta_pedido": horaAceptaPedido,
        "en_camino_al_cliente": enCaminoAlCliente,
        "hora_pedido_entregado": horaPedidoEntregado,
      };

  void marcarPedidoAceptado() {
    horaAceptaPedido = DateTime.now().millisecondsSinceEpoch;
    paso = 1;
    msjLog = 'Pedido aceptado';
  }

  void marcarLlegadaAlComercio() {
    llegoAlComercio = true;
    mensajeEnviado?.llegoAlComercio = true;
    paso = 2;
    msjLog = 'Llegó al comercio';
  }

  void marcarEnCaminoAlCliente() {
    enCaminoAlCliente = true;
    mensajeEnviado?.enCaminoAlCliente = true;
    paso = 3;
    msjLog = 'En camino al cliente';
  }

  void marcarPedidoEntregado() {
    horaPedidoEntregado = DateTime.now().millisecondsSinceEpoch;
    paso = 4;
    msjLog = 'Pedido entregado';
  }
}

class MensajeEnviado {
  bool? llegoAlComercio;
  bool? enCaminoAlCliente;

  MensajeEnviado({
    this.llegoAlComercio = false,
    this.enCaminoAlCliente = false,
  });

  factory MensajeEnviado.fromJson(Map<String, dynamic> json) => MensajeEnviado(
        llegoAlComercio: json["llego_al_comercio"],
        enCaminoAlCliente: json["en_camino_al_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "llego_al_comercio": llegoAlComercio,
        "en_camino_al_cliente": enCaminoAlCliente,
      };
}
