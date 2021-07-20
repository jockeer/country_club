import 'dart:convert';

Dependiente dependienteModelFromJson(String str) => Dependiente.fromJson(json.decode(str));

String dependienteModelToJson(Dependiente data) => json.encode(data.toJson());

class Dependientes{
  List<Dependiente> items = [];

  Dependientes();

  Dependientes.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final dependiente = new Dependiente.fromJson(item);

      items.add(dependiente);
    }
  }
}

class Dependiente {
    Dependiente({
        this.codigo,
        this.apPaterno,
        this.apMaterno,
        this.nombre,
        this.ci,
        this.origen,
        this.direccion,
        this.telefono,
        this.celular,
        this.email,
        this.titular,
        this.saldoTarjeta
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
    String titular;
    String saldoTarjeta;

    String email = '';
    String password = '';

    factory Dependiente.fromJson(Map<String, dynamic> json) => Dependiente(
      
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
        titular: json["titular"].toString(),
        saldoTarjeta: json["saldo_tarjeta"].toString(),
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
