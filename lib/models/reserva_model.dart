import 'dart:convert';

Reserva reservaModelFromJson(String str) => Reserva.fromJson(json.decode(str));

String reservaModelToJson(Reserva data) => json.encode(data.toJson());

class Reserva{
    Reserva({
        this.codecli,
        this.cabanaid,
        this.customerid,
        this.fecha,
        this.hora,
        this.cantidad,
        this.celular,
        this.nombre,
        this.requerimientos,
        this.estado
    });

    String codecli;
    String cabanaid;
    String customerid;
    String fecha;
    String hora;
    String cantidad;
    String celular;
    String nombre;
    String requerimientos;
    String estado;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        cabanaid: json["codigo"].toString(),
        customerid: json["ap_paterno"],
        fecha: json["ap_materno"],
        hora: json["nombre"],
        cantidad: json["ci"].toString(),
        celular: json["origen"],
        nombre: json["direccion"],
        requerimientos: json["telefono"],
        estado: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "cabanaid": cabanaid,
        "fecha": fecha,
        "hora": hora,
        "cantidad": cantidad,
        "celular": celular,
        "nombre": nombre,
        "requerimientos": requerimientos,
        "codecli": codecli,
    };
}
