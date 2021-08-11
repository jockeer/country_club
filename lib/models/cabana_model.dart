import 'dart:convert';

Cabana cabanaModelFromJson(String str) => Cabana.fromJson(json.decode(str));

String cabanaModelToJson(Cabana data) => json.encode(data.toJson());

class Cabanas{
  List<Cabana> items = [];

  Cabanas();

  Cabanas.fromJsonList(List<dynamic> jsonList ){
    if (jsonList==null) return;

    for (var item in jsonList) {
      final cabana = new Cabana.fromJson(item);

      items.add(cabana);
    }
  }
}

class Cabana{
    Cabana({
        this.id,
        this.nombreCabana,
        this.foto,
        this.cantidad
    });

    String id;
    String nombreCabana;
    String foto;
    String cantidad;

    factory Cabana.fromJson(Map<String, dynamic> json) => Cabana(
        id: json["id"],
        nombreCabana: json["nombreCabana"],
        foto: json["foto"],
        cantidad: json["cantidad"]

    );

    Map<String, dynamic> toJson() => {

    };
}
