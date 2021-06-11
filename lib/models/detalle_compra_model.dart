import 'dart:convert';

DetalleCompra compraModelFromJson(String str) => DetalleCompra.fromJson(json.decode(str));

String compraModelToJson(DetalleCompra data) => json.encode(data.toJson());

class Detalles{
  List<DetalleCompra> items = [];

  Detalles();

  Detalles.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final compra = new DetalleCompra.fromJson(item);

      items.add(compra);
    }
  }
}

class DetalleCompra {
    DetalleCompra({

        this.idVenta,
        this.producto,
        this.cantidad,
        this.precio,
        this.subTotal
    });


    String idVenta;
    String producto;
    int cantidad;
    double precio;
    double subTotal;

    factory DetalleCompra.fromJson(Map<String, dynamic> json) => DetalleCompra(

        idVenta: json["idventa"].toString(),
        producto: json["producto"],
        cantidad: json["cantidad"],
        precio: json["precio"],
        subTotal: json["subtotal"],

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
