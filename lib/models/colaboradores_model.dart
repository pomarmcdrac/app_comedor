// To parse this JSON data, do
//
//     final colaboradoresModel = colaboradoresModelFromMap(jsonString);

import 'dart:convert';

class ColaboradoresModel {
    List<SdtColaboradore> sdtColaboradores;

    ColaboradoresModel({
        required this.sdtColaboradores,
    });

    factory ColaboradoresModel.fromJson(String str) => ColaboradoresModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ColaboradoresModel.fromMap(Map<String, dynamic> json) => ColaboradoresModel(
        sdtColaboradores: List<SdtColaboradore>.from(json["SDT_Colaboradores"].map((x) => SdtColaboradore.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "SDT_Colaboradores": List<dynamic>.from(sdtColaboradores.map((x) => x.toMap())),
    };
}

class SdtColaboradore {
    int colaboradoresId;
    String colaboradoresClave;
    String colaboradoresNombre;
    String colaboradoresEmpresa;
    bool colaboradoresIsActive;
    String colaboradoresUbicacionBase;

    SdtColaboradore({
        required this.colaboradoresId,
        required this.colaboradoresClave,
        required this.colaboradoresNombre,
        required this.colaboradoresEmpresa,
        required this.colaboradoresIsActive,
        required this.colaboradoresUbicacionBase,
    });


    factory SdtColaboradore.fromJson(String str) => SdtColaboradore.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SdtColaboradore.fromMap(Map<String, dynamic> json) => SdtColaboradore(
        colaboradoresId: json["ColaboradoresId"],
        colaboradoresClave: json["ColaboradoresClave"],
        colaboradoresNombre: json["ColaboradoresNombre"],
        colaboradoresEmpresa: json["ColaboradoresEmpresa"],
        colaboradoresIsActive: json["ColaboradoresIsActive"],
        colaboradoresUbicacionBase: json["ColaboradoresUbicacionBase"],
    );

    Map<String, dynamic> toMap() => {
        "ColaboradoresId": colaboradoresId,
        "ColaboradoresClave": colaboradoresClave,
        "ColaboradoresNombre": colaboradoresNombre,
        "ColaboradoresEmpresa": colaboradoresEmpresa,
        "ColaboradoresIsActive": colaboradoresIsActive,
        "ColaboradoresUbicacionBase": colaboradoresUbicacionBase,
    };
}
