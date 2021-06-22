import 'dart:convert';

Deuda deudaModelFromJson(String str) => Deuda.fromJson(json.decode(str));

String deudaModelToJson(Deuda data) => json.encode(data.toJson());

class Deudas{
  List<Deuda> items = [];

  Deudas();

  Deudas.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final deuda = new Deuda.fromJson(item);

      items.add(deuda);
    }
  }
}

class Deuda {
  Deuda({
    this.codigo,
    this.idDeuda,
    this.detalle,
    this.tipo,
    this.fecha,
    this.total,
  });

  int codigo;
  int idDeuda;
  String detalle;
  String tipo;
  String fecha;
  double total;

  factory Deuda.fromJson(Map<String, dynamic> json) => Deuda(
      
    codigo: json["codigo"],
    idDeuda: json["iddeuda"],
    detalle: json["detalle"],
    tipo: json["tipo"],
    fecha: json["fecha"],
    total: json["total"],

  );

  Map<String, dynamic> toJson() => {

  };
}

