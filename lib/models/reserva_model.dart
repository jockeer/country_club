import 'dart:convert';

Reserva reservaModelFromJson(String str) => Reserva.fromJson(json.decode(str));

String reservaModelToJson(Reserva data) => json.encode(data.toJson());

class Reservas{
  List<Reserva> items = [];

  Reservas();

  Reservas.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final reserva = new Reserva.fromJson(item);

      items.add(reserva);
    }
  }
}

class Reserva{
    Reserva({
        this.id,
        this.codecli,
        this.cabanaid,
        this.customerid,
        this.fecha,
        this.hora,
        this.cantidad,
        this.celular,
        this.nombre,
        this.requerimientos,
        this.obs,
        this.motivo,
        this.status,
        this.estado,
        this.nombreCab,
        this.foto
    });

    String id;
    String codecli;
    String cabanaid;
    String customerid;
    String fecha;
    String hora;
    String cantidad;
    String celular;
    String nombre;
    String requerimientos;
    String obs;
    String motivo;
    String status;
    String estado;
    String nombreCab;
    String foto;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json["id"],
        cabanaid: json["cabanaid"],
        customerid: json["customerid"],
        fecha: json["fecha"],
        hora: json["hora"],
        cantidad: json["cantidad"],
        celular: json["celular"],
        nombre: json["nombreCustomer"], 
        motivo: json["motivo"], 
        requerimientos: json["requerimient"],
        status: json["status"],
        obs: json["obs"],
        nombreCab: json["nombreCabana"],
        foto: json["foto"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        // "id_reserva": id,
        "cabanaid": cabanaid,
        "fecha": fecha,
        "hora": hora,
        "cantidad": cantidad,
        "celular": celular,
        "nombre": nombre,
        "requerimientos": requerimientos,
        "codecli": codecli,
        "motivo": motivo
    };
}
