import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

Evento compraModelFromJson(String str) => Evento.fromJson(json.decode(str));

String compraModelToJson(Evento data) => json.encode(data.toJson());

class Eventos{
  List lista = [];
  Map<DateTime, List<Event>> events = {};

  Eventos();

  Eventos.fromJsonList(List<dynamic> jsonList, BuildContext context ){
    if (jsonList==null) return;
    
    for (var item in jsonList) {
      var newDate = Map<DateTime,List<Event>>();
      
      List<Event> listaNueva = [];
      for (var i = 0; i < int.parse(item["cantidad"]) ; i++) {
        Event evento = new Event(
          date: DateTime.parse(item["fecha"]),
          title: 'Event 1',
          icon: Icon(Icons.access_alarms_sharp),
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color:(item["start"]=="1"?Colors.green:Colors.red),
            height: 5,
            width: 5,
          )
        );
        lista.add(evento);
        listaNueva.add(evento);
      }
      newDate[DateTime.parse(item["fecha"])] = listaNueva;
      events.addAll(newDate);
    }

  }
}

class Evento {
    Evento({
        this.codigo,
        this.idVenta,
        this.totalVenta,
        this.area,
        this.fecha,
        this.nombre
    });

    String codigo;
    String idVenta;
    double totalVenta;
    String area;
    String fecha;
    String nombre;

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
      
        codigo: json["codigo"].toString(),
        nombre: json["nombre"],
        idVenta: json["idventa"].toString(),
        totalVenta: json["total_venta"],
        area: json["area"],
        fecha: json["fecha"],

    );

    Map<String, dynamic> toJson() => {

    };
}

