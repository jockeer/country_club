import 'dart:convert';

Socio socioModelFromJson(String str) => Socio.fromJson(json.decode(str));

String socioModelToJson(Socio data) => json.encode(data.toJson());

class Socio {
    Socio({
        this.codigo,
        this.apPaterno,
        this.apMaterno,
        this.nombre,
        this.ci,
        this.origen,
        this.direccion,
        this.telefono,
    });

    int codigo;
    String apPaterno;
    String apMaterno;
    String nombre;
    int ci;
    String origen;
    String direccion;
    String telefono;

    String email = '';
    String password = '';

    factory Socio.fromJson(Map<String, dynamic> json) => Socio(
        codigo: json["codigo"],
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        nombre: json["nombre"],
        ci: json["ci"],
        origen: json["origen"],
        direccion: json["direccion"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "ap_paterno": apPaterno,
        "ap_materno": apMaterno,
        "nombre": nombre,
        "ci": ci,
        "origen": origen,
        "direccion": direccion,
        "telefono": telefono,
    };
}
