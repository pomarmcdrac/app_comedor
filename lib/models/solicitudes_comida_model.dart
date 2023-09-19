// To parse this JSON data, do
//
//     final solicitudesComidaModel = solicitudesComidaModelFromMap(jsonString);

import 'dart:convert';

class SolicitudesComidaModel {
    List<SdtSolicitudesDeComida> sdtSolicitudesDeComida;

    SolicitudesComidaModel({
        required this.sdtSolicitudesDeComida,
    });

    factory SolicitudesComidaModel.fromJson(String str) => SolicitudesComidaModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SolicitudesComidaModel.fromMap(Map<String, dynamic> json) => SolicitudesComidaModel(
        sdtSolicitudesDeComida: List<SdtSolicitudesDeComida>.from(json["SDT_SolicitudesDeComida"].map((x) => SdtSolicitudesDeComida.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "SDT_SolicitudesDeComida": List<dynamic>.from(sdtSolicitudesDeComida.map((x) => x.toMap())),
    };
}

class SdtSolicitudesDeComida {
    String solicitudesDeComidaId;
    int colaboradoresId;
    String colaboradoresNombre;
    String colaboradoresEmpresa;
    String colaboradoresUbicacionBase;
    String colaboradoresClave;
    String solicitudesDeComidaPedido;
    String solicitudesDeComidaComentarios;
    bool solicitudesDeComidaIsTomada;
    DateTime solicitudesDeComidaFechaCreacion;
    DateTime solicitudesDeComidaFechaDeComida;

    SdtSolicitudesDeComida({
        required this.solicitudesDeComidaId,
        required this.colaboradoresId,
        required this.colaboradoresNombre,
        required this.colaboradoresEmpresa,
        required this.colaboradoresUbicacionBase,
        required this.colaboradoresClave,
        required this.solicitudesDeComidaPedido,
        required this.solicitudesDeComidaComentarios,
        required this.solicitudesDeComidaIsTomada,
        required this.solicitudesDeComidaFechaCreacion,
        required this.solicitudesDeComidaFechaDeComida,
    });

    factory SdtSolicitudesDeComida.fromJson(String str) => SdtSolicitudesDeComida.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SdtSolicitudesDeComida.fromMap(Map<String, dynamic> json) => SdtSolicitudesDeComida(
        solicitudesDeComidaId: json["SolicitudesDeComidaId"],
        colaboradoresId: json["ColaboradoresId"],
        colaboradoresNombre: json["ColaboradoresNombre"],
        colaboradoresEmpresa: json["ColaboradoresEmpresa"],
        colaboradoresUbicacionBase: json["ColaboradoresUbicacionBase"],
        colaboradoresClave: json["ColaboradoresClave"],
        solicitudesDeComidaPedido: json["SolicitudesDeComidaPedido"],
        solicitudesDeComidaComentarios: json["SolicitudesDeComidaComentarios"],
        solicitudesDeComidaIsTomada: json["SolicitudesDeComidaIsTomada"],
        solicitudesDeComidaFechaCreacion: DateTime.parse(json["SolicitudesDeComidaFechaCreacion"]),
        solicitudesDeComidaFechaDeComida: DateTime.parse(json["SolicitudesDeComidaFechaDeComida"]),
    );

    Map<String, dynamic> toMap() => {
        "SolicitudesDeComidaId": solicitudesDeComidaId,
        "ColaboradoresId": colaboradoresId,
        "ColaboradoresNombre": colaboradoresNombre,
        "ColaboradoresEmpresa": colaboradoresEmpresa,
        "ColaboradoresUbicacionBase": colaboradoresUbicacionBase,
        "ColaboradoresClave": colaboradoresClave,
        "SolicitudesDeComidaPedido": solicitudesDeComidaPedido,
        "SolicitudesDeComidaComentarios": solicitudesDeComidaComentarios,
        "SolicitudesDeComidaIsTomada": solicitudesDeComidaIsTomada,
        "SolicitudesDeComidaFechaCreacion": solicitudesDeComidaFechaCreacion.toIso8601String(),
        "SolicitudesDeComidaFechaDeComida": "${solicitudesDeComidaFechaDeComida.year.toString().padLeft(4, '0')}-${solicitudesDeComidaFechaDeComida.month.toString().padLeft(2, '0')}-${solicitudesDeComidaFechaDeComida.day.toString().padLeft(2, '0')}",
    };
}
