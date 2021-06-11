import 'dart:convert';

Compra compraModelFromJson(String str) => Compra.fromJson(json.decode(str));

String compraModelToJson(Compra data) => json.encode(data.toJson());

class Compras{
  List<Compra> items = [];

  Compras();

  Compras.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final compra = new Compra.fromJson(item);

      items.add(compra);
    }
  }
}

class Compra {
    Compra({
        this.codigo,
        this.idVenta,
        this.totalVenta,
        this.area,
        this.fecha
    });

    String codigo;
    String idVenta;
    double totalVenta;
    String area;
    String fecha;

    factory Compra.fromJson(Map<String, dynamic> json) => Compra(
      
        codigo: json["codigo"].toString(),
        idVenta: json["idventa"].toString(),
        totalVenta: json["total_venta"],
        area: json["area"],
        fecha: json["fecha"],

    );

    Map<String, dynamic> toJson() => {
        // "codecli": codigo,
        // "lastname_father": apPaterno,
        // "name": nombre,
        // "id_card": ci,
        // "expedition": origen,
        // "address": direccion,
        // "cell_phone": telefono,
        // "email": email,
        // "password": password
    };
}

