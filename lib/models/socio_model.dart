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
        this.celular,
        this.email
    });

    String codigo;
    String apPaterno;
    String apMaterno;
    String nombre;
    String ci;
    String origen;
    String direccion;
    String telefono;
    String celular;

    String email = '';
    String password = '';

    factory Socio.fromJson(Map<String, dynamic> json) => Socio(
      
        codigo: json["codigo"].toString(),
        apPaterno: json["ap_paterno"],
        apMaterno: json["ap_materno"],
        nombre: json["nombre"],
        ci: json["ci"].toString(),
        origen: json["origen"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        celular: json["celular"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "codecli": codigo,
        "lastname_father": apPaterno,
        "name": nombre,
        "id_card": ci,
        "expedition": origen,
        "address": direccion,
        "cell_phone": celular,
        "phone": telefono,
        "email": email,
        "password": password
    };
}
