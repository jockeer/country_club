import 'dart:convert';

Pago pagoModelFromJson(String str) => Pago.fromJson(json.decode(str));

String pagoModelToJson(Pago data) => json.encode(data.toJson());

class Pagos{
  List<Pago> items = [];

  Pagos();

  Pagos.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final pago = new Pago.fromJson(item);

      items.add(pago);
    }
  }
}

class Pago {
    Pago({
        this.codigo,
        this.idPago,
        this.totalPago,
        this.detalle,
        this.fecha
    });

    int codigo;
    int idPago;
    double totalPago;
    String detalle;
    String fecha;

    factory Pago.fromJson(Map<String, dynamic> json) => Pago(
      
        codigo: json["codigo"],
        idPago: json["idpago"],
        totalPago: json["total_pago"],
        detalle: json["detalle"],
        fecha: json["fecha"],

    );

    Map<String, dynamic> toJson() => {

    };
}

