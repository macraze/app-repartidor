// To parse this JSON data, do
//
//     final jsonDatosDelivery = jsonDatosDeliveryFromJson(jsonString);

import 'dart:convert';

JsonDatosDelivery jsonOneDatosDeliveryFromJson(String str) =>
    JsonDatosDelivery.fromJson(json.decode(str));

String jsonOneDatosDeliveryToJson(JsonDatosDelivery data) =>
    json.encode(data.toJson());

List<JsonDatosDelivery> jsonDatosDeliveryFromJson(String str) =>
    List<JsonDatosDelivery>.from(
        json.decode(str).map((x) => JsonDatosDelivery.fromJson(x)));

String jsonDatosDeliveryToJson(List<JsonDatosDelivery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonDatosDelivery {
  PBody? pBody;
  int? idpedido;
  PHeader? pHeader;
  List<PSubtotale>? pSubtotales;

  JsonDatosDelivery({
    this.pBody,
    this.idpedido,
    this.pHeader,
    this.pSubtotales,
  });

  factory JsonDatosDelivery.fromJson(Map<String, dynamic> json) =>
      JsonDatosDelivery(
        pBody: json["p_body"] == null ? null : PBody.fromJson(json["p_body"]),
        idpedido: json["idpedido"] == null ? null : json["idpedido"],
        pHeader: json["p_header"] == null
            ? null
            : PHeader.fromJson(json["p_header"]),
        pSubtotales: json["p_subtotales"] == null
            ? []
            : List<PSubtotale>.from(
                json["p_subtotales"]!.map((x) => PSubtotale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "p_body": pBody?.toJson(),
        "idpedido": idpedido,
        "p_header": pHeader?.toJson(),
        "p_subtotales": pSubtotales == null
            ? []
            : List<dynamic>.from(pSubtotales!.map((x) => x.toJson())),
      };
}

class PBody {
  List<Tipoconsumo>? tipoconsumo;

  PBody({
    this.tipoconsumo,
  });

  factory PBody.fromJson(Map<String, dynamic> json) => PBody(
        tipoconsumo: json["tipoconsumo"] == null
            ? []
            : List<Tipoconsumo>.from(
                json["tipoconsumo"]!.map((x) => Tipoconsumo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tipoconsumo": tipoconsumo == null
            ? []
            : List<dynamic>.from(tipoconsumo!.map((x) => x.toJson())),
      };
}

class Tipoconsumo {
  String? titulo;
  List<Seccione>? secciones;
  String? descripcion;
  int? idimpresora;
  dynamic idtipoConsumo;
  int? countItemsSeccion;
  int? cantidadSeleccionada;

  Tipoconsumo({
    this.titulo,
    this.secciones,
    this.descripcion,
    this.idimpresora,
    this.idtipoConsumo,
    this.countItemsSeccion,
    this.cantidadSeleccionada,
  });

  factory Tipoconsumo.fromJson(Map<String, dynamic> json) => Tipoconsumo(
        titulo: json["titulo"],
        secciones: json["secciones"] == null
            ? []
            : List<Seccione>.from(
                json["secciones"]!.map((x) => Seccione.fromJson(x))),
        descripcion: json["descripcion"],
        idimpresora: json["idimpresora"],
        idtipoConsumo: json["idtipo_consumo"],
        countItemsSeccion: json["count_items_seccion"],
        cantidadSeleccionada: json["cantidad_seleccionada"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "secciones": secciones == null
            ? []
            : List<dynamic>.from(secciones!.map((x) => x.toJson())),
        "descripcion": descripcion,
        "idimpresora": idimpresora,
        "idtipo_consumo": idtipoConsumo,
        "count_items_seccion": countItemsSeccion,
        "cantidad_seleccionada": cantidadSeleccionada,
      };
}

class Seccione {
  String? des;
  List<Item>? items;
  dynamic idseccion;
  int? secOrden;
  int? countItems;
  dynamic idimpresora;
  int? verStockCero;
  int? idimpresoraOtro;

  Seccione({
    this.des,
    this.items,
    this.idseccion,
    this.secOrden,
    this.countItems,
    this.idimpresora,
    this.verStockCero,
    this.idimpresoraOtro,
  });

  factory Seccione.fromJson(Map<String, dynamic> json) => Seccione(
        des: json["des"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        idseccion: json["idseccion"],
        secOrden: json["sec_orden"],
        countItems: json["count_items"],
        idimpresora: json["idimpresora"],
        verStockCero: json["ver_stock_cero"],
        idimpresoraOtro: json["idimpresora_otro"],
      );

  Map<String, dynamic> toJson() => {
        "des": des,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "idseccion": idseccion,
        "sec_orden": secOrden,
        "count_items": countItems,
        "idimpresora": idimpresora,
        "ver_stock_cero": verStockCero,
        "idimpresora_otro": idimpresoraOtro,
      };
}

class Item {
  String? des;
  String? img;
  dynamic iditem;
  dynamic precio;
  dynamic procede;
  String? seccion;
  bool? visible;
  dynamic cantidad;
  String? detalles;
  bool? selected;
  dynamic subitems;
  dynamic idseccion;
  dynamic isalmacen;
  String? isporcion;
  int? secOrden;
  String? desSeccion;
  int? idcategoria;
  dynamic idimpresora;
  String? precioPrint;
  dynamic precioTotal;
  String? idcartaLista;
  List<dynamic>? subitemsView;
  int? countSubitems;
  dynamic precioDefault;
  int? verStockCero;
  dynamic precioUnitario;
  dynamic imprimirComanda;
  String? isRecomendacion;
  List<dynamic>? itemtiposconsumo;
  dynamic precioTotalCalc;
  dynamic subitemCantSelect;
  int? cantidadSeleccionada;
  dynamic subitemRequiredSelect;
  bool? sumar;
  List<dynamic>? subitemsSelected;
  bool? isSearchSubitems;
  int? cantidadDescontado;

  Item({
    this.des,
    this.img,
    this.iditem,
    this.precio,
    this.procede,
    this.seccion,
    this.visible,
    this.cantidad,
    this.detalles,
    this.selected,
    this.subitems,
    this.idseccion,
    this.isalmacen,
    this.isporcion,
    this.secOrden,
    this.desSeccion,
    this.idcategoria,
    this.idimpresora,
    this.precioPrint,
    this.precioTotal,
    this.idcartaLista,
    this.subitemsView,
    this.countSubitems,
    this.precioDefault,
    this.verStockCero,
    this.precioUnitario,
    this.imprimirComanda,
    this.isRecomendacion,
    this.itemtiposconsumo,
    this.precioTotalCalc,
    this.subitemCantSelect,
    this.cantidadSeleccionada,
    this.subitemRequiredSelect,
    this.sumar,
    this.subitemsSelected,
    this.isSearchSubitems,
    this.cantidadDescontado,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        des: json["des"],
        img: json["img"],
        iditem: json["iditem"],
        precio: json["precio"],
        procede: json["procede"],
        seccion: json["seccion"],
        visible: json["visible"],
        cantidad: json["cantidad"],
        detalles: json["detalles"],
        selected: json["selected"],
        subitems: json["subitems"],
        idseccion: json["idseccion"],
        isalmacen: json["isalmacen"],
        isporcion: json["isporcion"],
        secOrden: json["sec_orden"],
        desSeccion: json["des_seccion"],
        idcategoria: json["idcategoria"],
        idimpresora: json["idimpresora"],
        precioPrint: json["precio_print"],
        precioTotal: json["precio_total"],
        idcartaLista: json["idcarta_lista"],
        subitemsView: json["subitems_view"] == null
            ? []
            : List<dynamic>.from(json["subitems_view"]!.map((x) => x)),
        countSubitems: json["count_subitems"],
        precioDefault: json["precio_default"],
        verStockCero: json["ver_stock_cero"],
        precioUnitario: json["precio_unitario"],
        imprimirComanda: json["imprimir_comanda"],
        isRecomendacion: json["is_recomendacion"],
        itemtiposconsumo: json["itemtiposconsumo"] == null
            ? []
            : List<dynamic>.from(json["itemtiposconsumo"]!.map((x) => x)),
        precioTotalCalc: json["precio_total_calc"],
        subitemCantSelect: json["subitem_cant_select"],
        cantidadSeleccionada: json["cantidad_seleccionada"],
        subitemRequiredSelect: json["subitem_required_select"],
        sumar: json["sumar"],
        subitemsSelected: json["subitems_selected"] == null
            ? []
            : List<dynamic>.from(json["subitems_selected"]!.map((x) => x)),
        isSearchSubitems: json["is_search_subitems"],
        cantidadDescontado: json["cantidad_descontado"],
      );

  Map<String, dynamic> toJson() => {
        "des": des,
        "img": img,
        "iditem": iditem,
        "precio": precio,
        "procede": procede,
        "seccion": seccion,
        "visible": visible,
        "cantidad": cantidad,
        "detalles": detalles,
        "selected": selected,
        "subitems": subitems,
        "idseccion": idseccion,
        "isalmacen": isalmacen,
        "isporcion": isporcion,
        "sec_orden": secOrden,
        "des_seccion": desSeccion,
        "idcategoria": idcategoria,
        "idimpresora": idimpresora,
        "precio_print": precioPrint,
        "precio_total": precioTotal,
        "idcarta_lista": idcartaLista,
        "subitems_view": subitemsView == null
            ? []
            : List<dynamic>.from(subitemsView!.map((x) => x)),
        "count_subitems": countSubitems,
        "precio_default": precioDefault,
        "ver_stock_cero": verStockCero,
        "precio_unitario": precioUnitario,
        "imprimir_comanda": imprimirComanda,
        "is_recomendacion": isRecomendacion,
        "itemtiposconsumo": itemtiposconsumo == null
            ? []
            : List<dynamic>.from(itemtiposconsumo!.map((x) => x)),
        "precio_total_calc": precioTotalCalc,
        "subitem_cant_select": subitemCantSelect,
        "cantidad_seleccionada": cantidadSeleccionada,
        "subitem_required_select": subitemRequiredSelect,
        "sumar": sumar,
        "subitems_selected": subitemsSelected == null
            ? []
            : List<dynamic>.from(subitemsSelected!.map((x) => x)),
        "is_search_subitems": isSearchSubitems,
        "cantidad_descontado": cantidadDescontado,
      };
}

class PHeader {
  String? m;
  String? r;
  String? appv;
  String? nomUs;
  int? delivery;
  int? reservar;
  String? systemOs;
  int? isCliente;
  String? mRespaldo;
  String? numPedido;
  String? idcategoria;
  int? soloLlevar;
  ArrDatosReserva? arrDatosReserva;
  String? correlativoDia;
  int? idregistroPago;
  String? numComprobante;
  ArrDatosDelivery? arrDatosDelivery;
  int? isprintAllShort;
  int? idregistraScanQr;
  int? isprintCopyShort;
  int? isPrintSubtotales;
  String? idclie;
  String? referencia;
  String? mesa;
  String? tipoConsumo;
  String? subtotalesTachados;
  String? isComercioAppDeliveryMapa;

  PHeader({
    this.m,
    this.r,
    this.appv,
    this.nomUs,
    this.delivery,
    this.reservar,
    this.systemOs,
    this.isCliente,
    this.mRespaldo,
    this.numPedido,
    this.idcategoria,
    this.soloLlevar,
    this.arrDatosReserva,
    this.correlativoDia,
    this.idregistroPago,
    this.numComprobante,
    this.arrDatosDelivery,
    this.isprintAllShort,
    this.idregistraScanQr,
    this.isprintCopyShort,
    this.isPrintSubtotales,
    this.idclie,
    this.referencia,
    this.mesa,
    this.tipoConsumo,
    this.subtotalesTachados,
    this.isComercioAppDeliveryMapa,
  });

  factory PHeader.fromJson(Map<String, dynamic> json) => PHeader(
        m: json["m"],
        r: json["r"],
        appv: json["appv"],
        nomUs: json["nom_us"],
        delivery: json["delivery"],
        reservar: json["reservar"],
        systemOs: json["systemOS"],
        isCliente: json["isCliente"],
        mRespaldo: json["m_respaldo"],
        numPedido: json["num_pedido"],
        idcategoria: json["idcategoria"],
        soloLlevar: json["solo_llevar"],
        arrDatosReserva: json["arrDatosReserva"] == null
            ? null
            : ArrDatosReserva.fromJson(json["arrDatosReserva"]),
        correlativoDia: json["correlativo_dia"],
        idregistroPago: json["idregistro_pago"],
        numComprobante: json["num_comprobante"],
        arrDatosDelivery: json["arrDatosDelivery"] == null
            ? null
            : ArrDatosDelivery.fromJson(json["arrDatosDelivery"]),
        isprintAllShort: json["isprint_all_short"],
        idregistraScanQr: json["idregistra_scan_qr"],
        isprintCopyShort: json["isprint_copy_short"],
        isPrintSubtotales: json["is_print_subtotales"],
        idclie: json["idclie"],
        referencia: json["referencia"],
        mesa: json["mesa"],
        tipoConsumo: json["tipo_consumo"],
        subtotalesTachados: json["subtotales_tachados"],
        isComercioAppDeliveryMapa: json["isComercioAppDeliveryMapa"],
      );

  Map<String, dynamic> toJson() => {
        "m": m,
        "r": r,
        "appv": appv,
        "nom_us": nomUs,
        "delivery": delivery,
        "reservar": reservar,
        "systemOS": systemOs,
        "isCliente": isCliente,
        "m_respaldo": mRespaldo,
        "num_pedido": numPedido,
        "idcategoria": idcategoria,
        "solo_llevar": soloLlevar,
        "arrDatosReserva": arrDatosReserva?.toJson(),
        "correlativo_dia": correlativoDia,
        "idregistro_pago": idregistroPago,
        "num_comprobante": numComprobante,
        "arrDatosDelivery": arrDatosDelivery?.toJson(),
        "isprint_all_short": isprintAllShort,
        "idregistra_scan_qr": idregistraScanQr,
        "isprint_copy_short": isprintCopyShort,
        "is_print_subtotales": isPrintSubtotales,
        "idclie": idclie,
        "referencia": referencia,
        "mesa": mesa,
        "tipo_consumo": tipoConsumo,
        "subtotales_tachados": subtotalesTachados,
        "isComercioAppDeliveryMapa": isComercioAppDeliveryMapa,
      };
}

class ArrDatosDelivery {
  String? dni;
  String? fNac;
  String? nombre;
  Propina? propina;
  String? pagaCon;
  String? telefono;
  String? direccion;
  dynamic idcliente;
  MetodoPago? metodoPago;
  List<SubTotale>? subTotales;
  bool? pasoRecoger;
  dynamic importeTotal;
  String? datoAdicional;
  Establecimiento? establecimiento;
  dynamic tipoComprobante;
  dynamic solicitaCubiertos;
  dynamic costoTotalDelivery;
  DireccionEnvioSelected? direccionEnvioSelected;
  dynamic tiempoEntregaProgamado;
  String? referencia;
  int? isFromComercio;
  dynamic numVerificador;
  bool? buscarRepartidor;
  int? delivery;
  String? nombres;

  ArrDatosDelivery({
    this.dni,
    this.fNac,
    this.nombre,
    this.propina,
    this.pagaCon,
    this.telefono,
    this.direccion,
    this.idcliente,
    this.metodoPago,
    this.subTotales,
    this.pasoRecoger,
    this.importeTotal,
    this.datoAdicional,
    this.establecimiento,
    this.tipoComprobante,
    this.solicitaCubiertos,
    this.costoTotalDelivery,
    this.direccionEnvioSelected,
    this.tiempoEntregaProgamado,
    this.referencia,
    this.isFromComercio,
    this.numVerificador,
    this.buscarRepartidor,
    this.delivery,
    this.nombres,
  });

  factory ArrDatosDelivery.fromJson(Map<String, dynamic> json) =>
      ArrDatosDelivery(
        dni: json["dni"],
        fNac: json["f_nac"],
        nombre: json["nombre"],
        propina: _parsePropina(json["propina"]),
        pagaCon: json["paga_con"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        idcliente: json["idcliente"],
        metodoPago: json["metodoPago"] == null
            ? null
            : MetodoPago.fromJson(json["metodoPago"]),
        subTotales: json["subTotales"] == null
            ? []
            : List<SubTotale>.from(
                json["subTotales"]!.map((x) => SubTotale.fromJson(x))),
        pasoRecoger: json["pasoRecoger"],
        importeTotal: json["importeTotal"],
        datoAdicional: json["dato_adicional"],
        establecimiento: json["establecimiento"] == null
            ? null
            : Establecimiento.fromJson(json["establecimiento"]),
        tipoComprobante: json["tipoComprobante"],
        solicitaCubiertos: json["solicitaCubiertos"],
        costoTotalDelivery: json["costoTotalDelivery"],
        direccionEnvioSelected: json["direccionEnvioSelected"] == null
            ? null
            : DireccionEnvioSelected.fromJson(json["direccionEnvioSelected"]),
        tiempoEntregaProgamado: json["tiempoEntregaProgamado"],
        referencia: json["referencia"],
        isFromComercio: json["isFromComercio"],
        numVerificador: json["num_verificador"],
        buscarRepartidor: json["buscarRepartidor"],
        delivery: json["delivery"],
        nombres: json["nombres"],
      );

  static Propina? _parsePropina(dynamic propinaData) {
    if (propinaData == null) {
      return null;
    }
    if (propinaData is List && propinaData.isNotEmpty) {
      return Propina.fromJson(propinaData[0]);
    } else if (propinaData is Map<String, dynamic>) {
      return Propina.fromJson(propinaData);
    }

    // Puedes manejar otros casos según tus necesidades
    return null;
  }

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "f_nac": fNac,
        "nombre": nombre,
        "propina": propina?.toJson(),
        "paga_con": pagaCon,
        "telefono": telefono,
        "direccion": direccion,
        "idcliente": idcliente,
        "metodoPago": metodoPago?.toJson(),
        "subTotales": subTotales == null
            ? []
            : List<dynamic>.from(subTotales!.map((x) => x.toJson())),
        "pasoRecoger": pasoRecoger,
        "importeTotal": importeTotal,
        "dato_adicional": datoAdicional,
        "establecimiento": establecimiento?.toJson(),
        "tipoComprobante": tipoComprobante,
        "solicitaCubiertos": solicitaCubiertos,
        "costoTotalDelivery": costoTotalDelivery,
        "direccionEnvioSelected": direccionEnvioSelected?.toJson(),
        "tiempoEntregaProgamado": tiempoEntregaProgamado,
        "referencia": referencia,
        "isFromComercio": isFromComercio,
        "num_verificador": numVerificador,
        "buscarRepartidor": buscarRepartidor,
        "delivery": delivery,
        "nombres": nombres,
      };
}

class DireccionEnvioSelected {
  String? pais;
  String? ciudad;
  String? codigo;
  String? titulo;
  Options? options;
  dynamic latitude;
  String? direccion;
  dynamic longitude;
  String? provincia;
  String? departamento;
  dynamic idclientePwaDireccion;
  String? referencia;
  String? idcliente;
  String? numDoc;
  String? nombre;
  String? telefono;
  String? pagaCon;
  String? fNac;
  List<DireccionDeliveryNoMap>? direccionDeliveryNoMap;
  String? solicitaCubiertos;
  String? nombres;

  DireccionEnvioSelected({
    this.pais,
    this.ciudad,
    this.codigo,
    this.titulo,
    this.options,
    this.latitude,
    this.direccion,
    this.longitude,
    this.provincia,
    this.departamento,
    this.idclientePwaDireccion,
    this.referencia,
    this.idcliente,
    this.numDoc,
    this.nombre,
    this.telefono,
    this.pagaCon,
    this.fNac,
    this.direccionDeliveryNoMap,
    this.solicitaCubiertos,
    this.nombres,
  });

  factory DireccionEnvioSelected.fromJson(Map<String, dynamic> json) =>
      DireccionEnvioSelected(
        pais: json["pais"],
        ciudad: json["ciudad"],
        codigo: json["codigo"],
        titulo: json["titulo"],
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
        latitude: json["latitude"],
        direccion: json["direccion"],
        longitude: json["longitude"],
        provincia: json["provincia"],
        departamento: json["departamento"],
        idclientePwaDireccion: json["idcliente_pwa_direccion"],
        referencia: json["referencia"],
        idcliente: json["idcliente"],
        numDoc: json["num_doc"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        pagaCon: json["paga_con"],
        fNac: json["f_nac"],
        direccionDeliveryNoMap: json["direccion_delivery_no_map"] == null
            ? []
            : List<DireccionDeliveryNoMap>.from(
                json["direccion_delivery_no_map"]!
                    .map((x) => DireccionDeliveryNoMap.fromJson(x))),
        solicitaCubiertos: json["solicitaCubiertos"],
        nombres: json["nombres"],
      );

  Map<String, dynamic> toJson() => {
        "pais": pais,
        "ciudad": ciudad,
        "codigo": codigo,
        "titulo": titulo,
        "options": options?.toJson(),
        "latitude": latitude,
        "direccion": direccion,
        "longitude": longitude,
        "provincia": provincia,
        "departamento": departamento,
        "idcliente_pwa_direccion": idclientePwaDireccion,
        "referencia": referencia,
        "idcliente": idcliente,
        "num_doc": numDoc,
        "nombre": nombre,
        "telefono": telefono,
        "paga_con": pagaCon,
        "f_nac": fNac,
        "direccion_delivery_no_map": direccionDeliveryNoMap == null
            ? []
            : List<dynamic>.from(
                direccionDeliveryNoMap!.map((x) => x.toJson())),
        "solicitaCubiertos": solicitaCubiertos,
        "nombres": nombres,
      };
}

class DireccionDeliveryNoMap {
  String? direccion;
  String? referencia;

  DireccionDeliveryNoMap({
    this.direccion,
    this.referencia,
  });

  factory DireccionDeliveryNoMap.fromJson(Map<String, dynamic> json) =>
      DireccionDeliveryNoMap(
        direccion: json["direccion"],
        referencia: json["referencia"],
      );

  Map<String, dynamic> toJson() => {
        "direccion": direccion,
        "referencia": referencia,
      };
}

class Options {
  int? vista;
  String? sDias;
  String? sHfin;
  String? sHini;
  int? costoExpress;
  int? costoMandado;
  String? sTiempoAprox;

  Options({
    this.vista,
    this.sDias,
    this.sHfin,
    this.sHini,
    this.costoExpress,
    this.costoMandado,
    this.sTiempoAprox,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        vista: json["vista"],
        sDias: json["s_dias"],
        sHfin: json["s_hfin"],
        sHini: json["s_hini"],
        costoExpress: json["costo_express"],
        costoMandado: json["costo_mandado"],
        sTiempoAprox: json["s_tiempo_aprox"],
      );

  Map<String, dynamic> toJson() => {
        "vista": vista,
        "s_dias": sDias,
        "s_hfin": sHfin,
        "s_hini": sHini,
        "costo_express": costoExpress,
        "costo_mandado": costoMandado,
        "s_tiempo_aprox": sTiempoAprox,
      };
}

class Establecimiento {
  String? a;
  int? cKm;
  dynamic idorg;
  String? ciudad;
  dynamic idsede;
  String? nombre;
  String? abreEn;
  int? cerrado;
  String? eslogan;
  int? isRain;
  bool? visible;
  int? cMinimo;
  String? horaFin;
  String? horaIni;
  dynamic latitude;
  String? direccion;
  double? distances;
  dynamic longitude;
  String? provincia;
  int? cServicio;
  List<Impresora>? impresoras;
  double? calificacion;
  String? departamento;
  String? distanciaKm;
  String? distanciaMt;
  String? codigoPostal;
  String? diasAtienden;
  List<IconsEntrega>? iconsEntrega;
  int? nuevoIngreso;
  String? subCategoria;
  String? simboloMoneda;
  bool? isCalcApiGoogle;
  List<RulesSubTotale>? rulesSubTotales;
  int? cantidadPedidos;
  int? idsedeCategoria;
  String? pwaDeliveryImg;
  int? pwaOrdenPagado;
  String? idsedeSubcategoria;
  int? pwaAceptaReservas;
  String? tiempoAproxEntrega;
  ParametrosTiendaLinea? parametrosTiendaLinea;
  String? pwaAceptaReservaDesde;
  int? pwaDeliveryAceptaYape;
  int? pwaDeliveryImporteMin;
  int? pwaShowItemViewMercado;
  int? pwaDeliveryAceptaTarjeta;
  int? pwaHabilitarBusquedaMapa;
  int? pwaDeliveryComercioOnline;
  int? pwaDeliveryServicioPropio;
  int? costoTotalServicioDelivery;
  int? pwaDeliveryRepartoSoloApp;
  int? pwaDeliveryComercioSolidaridad;
  int? pwaDeliveryComercioPagaEntrega;
  int? pwaPedidoProgramadoSoloDelDia;
  String? pwaDeliveryHabilitarRecojoLocal;
  int? pwaDeliveryComisionFijaNoAfiliado;
  int? pwaDeliveryHabilitarPedidoProgramado;
  int? pwaDeliveryHablitarCalcCostoServicio;
  int? pwaDeliveryHabilitarLlamarRepartidorPapaya;
  int? pwaDeliveryHabilitarCalcCostoServicioSoloApp;
  int? speechDisabled;
  String? telefono;
  String? mesas;
  String? maximoPedidosXHora;
  String? authorizationApiComprobante;
  String? idApiComprobante;
  String? facturacionEActivo;
  String? logo64;

  Establecimiento({
    this.a,
    this.cKm,
    this.idorg,
    this.ciudad,
    this.idsede,
    this.nombre,
    this.abreEn,
    this.cerrado,
    this.eslogan,
    this.isRain,
    this.visible,
    this.cMinimo,
    this.horaFin,
    this.horaIni,
    this.latitude,
    this.direccion,
    this.distances,
    this.longitude,
    this.provincia,
    this.cServicio,
    this.impresoras,
    this.calificacion,
    this.departamento,
    this.distanciaKm,
    this.distanciaMt,
    this.codigoPostal,
    this.diasAtienden,
    this.iconsEntrega,
    this.nuevoIngreso,
    this.subCategoria,
    this.simboloMoneda,
    this.isCalcApiGoogle,
    this.rulesSubTotales,
    this.cantidadPedidos,
    this.idsedeCategoria,
    this.pwaDeliveryImg,
    this.pwaOrdenPagado,
    this.idsedeSubcategoria,
    this.pwaAceptaReservas,
    this.tiempoAproxEntrega,
    this.parametrosTiendaLinea,
    this.pwaAceptaReservaDesde,
    this.pwaDeliveryAceptaYape,
    this.pwaDeliveryImporteMin,
    this.pwaShowItemViewMercado,
    this.pwaDeliveryAceptaTarjeta,
    this.pwaHabilitarBusquedaMapa,
    this.pwaDeliveryComercioOnline,
    this.pwaDeliveryServicioPropio,
    this.costoTotalServicioDelivery,
    this.pwaDeliveryRepartoSoloApp,
    this.pwaDeliveryComercioSolidaridad,
    this.pwaDeliveryComercioPagaEntrega,
    this.pwaPedidoProgramadoSoloDelDia,
    this.pwaDeliveryHabilitarRecojoLocal,
    this.pwaDeliveryComisionFijaNoAfiliado,
    this.pwaDeliveryHabilitarPedidoProgramado,
    this.pwaDeliveryHablitarCalcCostoServicio,
    this.pwaDeliveryHabilitarLlamarRepartidorPapaya,
    this.pwaDeliveryHabilitarCalcCostoServicioSoloApp,
    this.speechDisabled,
    this.telefono,
    this.mesas,
    this.maximoPedidosXHora,
    this.authorizationApiComprobante,
    this.idApiComprobante,
    this.facturacionEActivo,
    this.logo64,
  });

  factory Establecimiento.fromJson(Map<String, dynamic> json) =>
      Establecimiento(
        a: json["a"],
        cKm: json["c_km"],
        idorg: json["idorg"],
        ciudad: json["ciudad"],
        idsede: json["idsede"],
        nombre: json["nombre"],
        abreEn: json["abre_en"],
        cerrado: json["cerrado"],
        eslogan: json["eslogan"],
        isRain: json["is_rain"],
        visible: json["visible"],
        cMinimo: json["c_minimo"],
        horaFin: json["hora_fin"],
        horaIni: json["hora_ini"],
        latitude: json["latitude"],
        direccion: json["direccion"],
        distances: json["distances"]?.toDouble(),
        longitude: json["longitude"],
        provincia: json["provincia"],
        cServicio: json["c_servicio"],
        impresoras: json["impresoras"] == null
            ? []
            : List<Impresora>.from(
                json["impresoras"]!.map((x) => Impresora.fromJson(x))),
        calificacion: json["calificacion"]?.toDouble(),
        departamento: json["departamento"],
        distanciaKm: json["distancia_km"],
        distanciaMt: json["distancia_mt"],
        codigoPostal: json["codigo_postal"],
        diasAtienden: json["dias_atienden"],
        iconsEntrega: json["icons_entrega"] == null
            ? []
            : List<IconsEntrega>.from(
                json["icons_entrega"]!.map((x) => IconsEntrega.fromJson(x))),
        nuevoIngreso: json["nuevo_ingreso"],
        subCategoria: json["sub_categoria"],
        simboloMoneda: json["simbolo_moneda"],
        isCalcApiGoogle: json["isCalcApiGoogle"],
        rulesSubTotales: json["rulesSubTotales"] == null
            ? []
            : List<RulesSubTotale>.from(json["rulesSubTotales"]!
                .map((x) => RulesSubTotale.fromJson(x))),
        cantidadPedidos: json["cantidad_pedidos"],
        idsedeCategoria: json["idsede_categoria"],
        pwaDeliveryImg: json["pwa_delivery_img"],
        pwaOrdenPagado: json["pwa_orden_pagado"],
        idsedeSubcategoria: json["idsede_subcategoria"],
        pwaAceptaReservas: json["pwa_acepta_reservas"],
        tiempoAproxEntrega: json["tiempo_aprox_entrega"],
        parametrosTiendaLinea: json["parametros_tienda_linea"] == null
            ? null
            : ParametrosTiendaLinea.fromJson(json["parametros_tienda_linea"]),
        pwaAceptaReservaDesde: json["pwa_acepta_reserva_desde"],
        pwaDeliveryAceptaYape: json["pwa_delivery_acepta_yape"],
        pwaDeliveryImporteMin: json["pwa_delivery_importe_min"],
        pwaShowItemViewMercado: json["pwa_show_item_view_mercado"],
        pwaDeliveryAceptaTarjeta: json["pwa_delivery_acepta_tarjeta"],
        pwaHabilitarBusquedaMapa: json["pwa_habilitar_busqueda_mapa"],
        pwaDeliveryComercioOnline: json["pwa_delivery_comercio_online"],
        pwaDeliveryServicioPropio: json["pwa_delivery_servicio_propio"],
        costoTotalServicioDelivery: json["costo_total_servicio_delivery"],
        pwaDeliveryRepartoSoloApp: json["pwa_delivery_reparto_solo_app"],
        pwaDeliveryComercioSolidaridad:
            json["pwa_delivery_comercio_solidaridad"],
        pwaDeliveryComercioPagaEntrega:
            json["pwa_delivery_comercio_paga_entrega"],
        pwaPedidoProgramadoSoloDelDia:
            json["pwa_pedido_programado_solo_del_dia"],
        pwaDeliveryHabilitarRecojoLocal:
            json["pwa_delivery_habilitar_recojo_local"],
        pwaDeliveryComisionFijaNoAfiliado:
            json["pwa_delivery_comision_fija_no_afiliado"],
        pwaDeliveryHabilitarPedidoProgramado:
            json["pwa_delivery_habilitar_pedido_programado"],
        pwaDeliveryHablitarCalcCostoServicio:
            json["pwa_delivery_hablitar_calc_costo_servicio"],
        pwaDeliveryHabilitarLlamarRepartidorPapaya:
            json["pwa_delivery_habilitar_llamar_repartidor_papaya"],
        pwaDeliveryHabilitarCalcCostoServicioSoloApp:
            json["pwa_delivery_habilitar_calc_costo_servicio_solo_app"],
        speechDisabled: json["speech_disabled"],
        telefono: json["telefono"],
        mesas: json["mesas"],
        maximoPedidosXHora: json["maximo_pedidos_x_hora"],
        authorizationApiComprobante: json["authorization_api_comprobante"],
        idApiComprobante: json["id_api_comprobante"],
        facturacionEActivo: json["facturacion_e_activo"],
        logo64: json["logo64"],
      );

  Map<String, dynamic> toJson() => {
        "a": a,
        "c_km": cKm,
        "idorg": idorg,
        "ciudad": ciudad,
        "idsede": idsede,
        "nombre": nombre,
        "abre_en": abreEn,
        "cerrado": cerrado,
        "eslogan": eslogan,
        "is_rain": isRain,
        "visible": visible,
        "c_minimo": cMinimo,
        "hora_fin": horaFin,
        "hora_ini": horaIni,
        "latitude": latitude,
        "direccion": direccion,
        "distances": distances,
        "longitude": longitude,
        "provincia": provincia,
        "c_servicio": cServicio,
        "impresoras": impresoras == null
            ? []
            : List<dynamic>.from(impresoras!.map((x) => x.toJson())),
        "calificacion": calificacion,
        "departamento": departamento,
        "distancia_km": distanciaKm,
        "distancia_mt": distanciaMt,
        "codigo_postal": codigoPostal,
        "dias_atienden": diasAtienden,
        "icons_entrega": iconsEntrega == null
            ? []
            : List<dynamic>.from(iconsEntrega!.map((x) => x.toJson())),
        "nuevo_ingreso": nuevoIngreso,
        "sub_categoria": subCategoria,
        "simbolo_moneda": simboloMoneda,
        "isCalcApiGoogle": isCalcApiGoogle,
        "rulesSubTotales": rulesSubTotales == null
            ? []
            : List<dynamic>.from(rulesSubTotales!.map((x) => x.toJson())),
        "cantidad_pedidos": cantidadPedidos,
        "idsede_categoria": idsedeCategoria,
        "pwa_delivery_img": pwaDeliveryImg,
        "pwa_orden_pagado": pwaOrdenPagado,
        "idsede_subcategoria": idsedeSubcategoria,
        "pwa_acepta_reservas": pwaAceptaReservas,
        "tiempo_aprox_entrega": tiempoAproxEntrega,
        "parametros_tienda_linea": parametrosTiendaLinea?.toJson(),
        "pwa_acepta_reserva_desde": pwaAceptaReservaDesde,
        "pwa_delivery_acepta_yape": pwaDeliveryAceptaYape,
        "pwa_delivery_importe_min": pwaDeliveryImporteMin,
        "pwa_show_item_view_mercado": pwaShowItemViewMercado,
        "pwa_delivery_acepta_tarjeta": pwaDeliveryAceptaTarjeta,
        "pwa_habilitar_busqueda_mapa": pwaHabilitarBusquedaMapa,
        "pwa_delivery_comercio_online": pwaDeliveryComercioOnline,
        "pwa_delivery_servicio_propio": pwaDeliveryServicioPropio,
        "costo_total_servicio_delivery": costoTotalServicioDelivery,
        "pwa_delivery_reparto_solo_app": pwaDeliveryRepartoSoloApp,
        "pwa_delivery_comercio_solidaridad": pwaDeliveryComercioSolidaridad,
        "pwa_delivery_comercio_paga_entrega": pwaDeliveryComercioPagaEntrega,
        "pwa_pedido_programado_solo_del_dia": pwaPedidoProgramadoSoloDelDia,
        "pwa_delivery_habilitar_recojo_local": pwaDeliveryHabilitarRecojoLocal,
        "pwa_delivery_comision_fija_no_afiliado":
            pwaDeliveryComisionFijaNoAfiliado,
        "pwa_delivery_habilitar_pedido_programado":
            pwaDeliveryHabilitarPedidoProgramado,
        "pwa_delivery_hablitar_calc_costo_servicio":
            pwaDeliveryHablitarCalcCostoServicio,
        "pwa_delivery_habilitar_llamar_repartidor_papaya":
            pwaDeliveryHabilitarLlamarRepartidorPapaya,
        "pwa_delivery_habilitar_calc_costo_servicio_solo_app":
            pwaDeliveryHabilitarCalcCostoServicioSoloApp,
        "speech_disabled": speechDisabled,
        "telefono": telefono,
        "mesas": mesas,
        "maximo_pedidos_x_hora": maximoPedidosXHora,
        "authorization_api_comprobante": authorizationApiComprobante,
        "id_api_comprobante": idApiComprobante,
        "facturacion_e_activo": facturacionEActivo,
        "logo64": logo64,
      };
}

class IconsEntrega {
  String? icon;
  String? motivo;
  bool? visible;

  IconsEntrega({
    this.icon,
    this.motivo,
    this.visible,
  });

  factory IconsEntrega.fromJson(Map<String, dynamic> json) => IconsEntrega(
        icon: json["icon"],
        motivo: json["motivo"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "motivo": motivo,
        "visible": visible,
      };
}

class Impresora {
  String? ip;
  int? local;
  int? numCopias;
  int? papelSize;
  int? copiaLocal;
  String? descripcion;
  int? idimpresora;
  String? idtipoOtro;
  int? varMargenIz;
  int? varSizeFont;

  Impresora({
    this.ip,
    this.local,
    this.numCopias,
    this.papelSize,
    this.copiaLocal,
    this.descripcion,
    this.idimpresora,
    this.idtipoOtro,
    this.varMargenIz,
    this.varSizeFont,
  });

  factory Impresora.fromJson(Map<String, dynamic> json) => Impresora(
        ip: json["ip"],
        local: json["local"],
        numCopias: json["num_copias"],
        papelSize: json["papel_size"],
        copiaLocal: json["copia_local"],
        descripcion: json["descripcion"],
        idimpresora: json["idimpresora"],
        idtipoOtro: json["idtipo_otro"],
        varMargenIz: json["var_margen_iz"],
        varSizeFont: json["var_size_font"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "local": local,
        "num_copias": numCopias,
        "papel_size": papelSize,
        "copia_local": copiaLocal,
        "descripcion": descripcion,
        "idimpresora": idimpresora,
        "idtipo_otro": idtipoOtro,
        "var_margen_iz": varMargenIz,
        "var_size_font": varSizeFont,
      };
}

class ParametrosTiendaLinea {
  String? kmBase;
  String? kmLimite;
  String? kmBaseCosto;
  String? kmAdicionalCosto;

  ParametrosTiendaLinea({
    this.kmBase,
    this.kmLimite,
    this.kmBaseCosto,
    this.kmAdicionalCosto,
  });

  factory ParametrosTiendaLinea.fromJson(Map<String, dynamic> json) =>
      ParametrosTiendaLinea(
        kmBase: json["km_base"],
        kmLimite: json["km_limite"],
        kmBaseCosto: json["km_base_costo"],
        kmAdicionalCosto: json["km_adicional_costo"],
      );

  Map<String, dynamic> toJson() => {
        "km_base": kmBase,
        "km_limite": kmLimite,
        "km_base_costo": kmBaseCosto,
        "km_adicional_costo": kmAdicionalCosto,
      };
}

class RulesSubTotale {
  int? id;
  String? tipo;
  String? monto;
  int? nivel;
  int? activo;
  int? idseccion;
  String? descripcion;
  int? esImpuesto;
  int? idtipoConsumo;

  RulesSubTotale({
    this.id,
    this.tipo,
    this.monto,
    this.nivel,
    this.activo,
    this.idseccion,
    this.descripcion,
    this.esImpuesto,
    this.idtipoConsumo,
  });

  factory RulesSubTotale.fromJson(Map<String, dynamic> json) => RulesSubTotale(
        id: json["id"],
        tipo: json["tipo"],
        monto: json["monto"],
        nivel: json["nivel"],
        activo: json["activo"],
        idseccion: json["idseccion"],
        descripcion: json["descripcion"],
        esImpuesto: json["es_impuesto"],
        idtipoConsumo: json["idtipo_consumo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "monto": monto,
        "nivel": nivel,
        "activo": activo,
        "idseccion": idseccion,
        "descripcion": descripcion,
        "es_impuesto": esImpuesto,
        "idtipo_consumo": idtipoConsumo,
      };
}

class MetodoPago {
  String? img;
  String? info;
  bool? checked;
  String? importe;
  bool? visible;
  String? descripcion;
  dynamic idtipoPago;

  MetodoPago({
    this.img,
    this.info,
    this.checked,
    this.importe,
    this.visible,
    this.descripcion,
    this.idtipoPago,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        img: json["img"],
        info: json["info"],
        checked: json["checked"],
        importe: json["importe"],
        visible: json["visible"],
        descripcion: json["descripcion"],
        idtipoPago: json["idtipo_pago"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "info": info,
        "checked": checked,
        "importe": importe,
        "visible": visible,
        "descripcion": descripcion,
        "idtipo_pago": idtipoPago,
      };
}

class PropinaClass {
  int? value;
  bool? checked;
  int? idpropina;
  String? descripcion;

  PropinaClass({
    this.value,
    this.checked,
    this.idpropina,
    this.descripcion,
  });

  factory PropinaClass.fromJson(Map<String, dynamic> json) => PropinaClass(
        value: json["value"],
        checked: json["checked"],
        idpropina: json["idpropina"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "checked": checked,
        "idpropina": idpropina,
        "descripcion": descripcion,
      };
}

class Propina {
  String? importe;

  Propina({
    this.importe,
  });

  factory Propina.fromJson(Map<String, dynamic> json) => Propina(
        importe: json["importe"],
      );

  Map<String, dynamic> toJson() => {
        "importe": importe,
      };
}

class SubTotale {
  dynamic id;
  bool? quitar;
  dynamic importe;
  bool? tachado;
  bool? visible;
  int? esImpuesto;
  String? descripcion;
  bool? visibleCpe;
  bool? isDeliveryApp;

  SubTotale({
    this.id,
    this.quitar,
    this.importe,
    this.tachado,
    this.visible,
    this.esImpuesto,
    this.descripcion,
    this.visibleCpe,
    this.isDeliveryApp,
  });

  factory SubTotale.fromJson(Map<String, dynamic> json) => SubTotale(
        id: json["id"],
        quitar: json["quitar"],
        importe: json["importe"],
        tachado: json["tachado"],
        visible: json["visible"],
        esImpuesto: json["esImpuesto"],
        descripcion: json["descripcion"],
        visibleCpe: json["visible_cpe"],
        isDeliveryApp: json["isDeliveryApp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quitar": quitar,
        "importe": importe,
        "tachado": tachado,
        "visible": visible,
        "esImpuesto": esImpuesto,
        "descripcion": descripcion,
        "visible_cpe": visibleCpe,
        "isDeliveryApp": isDeliveryApp,
      };
}

class TiempoEntregaProgamadoClass {
  bool? valid;
  String? value;
  bool? modificado;
  String? descripcion;

  TiempoEntregaProgamadoClass({
    this.valid,
    this.value,
    this.modificado,
    this.descripcion,
  });

  factory TiempoEntregaProgamadoClass.fromJson(Map<String, dynamic> json) =>
      TiempoEntregaProgamadoClass(
        valid: json["valid"],
        value: json["value"],
        modificado: json["modificado"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "valid": valid,
        "value": value,
        "modificado": modificado,
        "descripcion": descripcion,
      };
}

class TipoComprobanteClass {
  bool? checked;
  String? descripcion;
  int? idtipoComprobante;

  TipoComprobanteClass({
    this.checked,
    this.descripcion,
    this.idtipoComprobante,
  });

  factory TipoComprobanteClass.fromJson(Map<String, dynamic> json) =>
      TipoComprobanteClass(
        checked: json["checked"],
        descripcion: json["descripcion"],
        idtipoComprobante: json["idtipo_comprobante"],
      );

  Map<String, dynamic> toJson() => {
        "checked": checked,
        "descripcion": descripcion,
        "idtipo_comprobante": idtipoComprobante,
      };
}

class ArrDatosReserva {
  ArrDatosReserva();

  factory ArrDatosReserva.fromJson(Map<String, dynamic> json) =>
      ArrDatosReserva();

  Map<String, dynamic> toJson() => {};
}

class PSubtotale {
  dynamic id;
  bool? quitar;
  dynamic importe;
  bool? tachado;
  bool? visible;
  dynamic esImpuesto;
  String? descripcion;
  bool? visibleCpe;
  bool? isDeliveryApp;
  String? importeTachado;
  String? punitario;

  PSubtotale({
    this.id,
    this.quitar,
    this.importe,
    this.tachado,
    this.visible,
    this.esImpuesto,
    this.descripcion,
    this.visibleCpe,
    this.isDeliveryApp,
    this.importeTachado,
    this.punitario,
  });

  factory PSubtotale.fromJson(Map<String, dynamic> json) => PSubtotale(
        id: json["id"],
        quitar: json["quitar"],
        importe: json["importe"],
        tachado: json["tachado"],
        visible: json["visible"],
        esImpuesto: json["esImpuesto"],
        descripcion: json["descripcion"],
        visibleCpe: json["visible_cpe"],
        isDeliveryApp: json["isDeliveryApp"],
        importeTachado: json["importe_tachado"],
        punitario: json["punitario"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quitar": quitar,
        "importe": importe,
        "tachado": tachado,
        "visible": visible,
        "esImpuesto": esImpuesto,
        "descripcion": descripcion,
        "visible_cpe": visibleCpe,
        "isDeliveryApp": isDeliveryApp,
        "importe_tachado": importeTachado,
        "punitario": punitario,
      };
}
