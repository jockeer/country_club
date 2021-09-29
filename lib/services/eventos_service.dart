import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/eventos_model.dart';

import 'package:country/utils/comprobar_conexion.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class EventosService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  bool cargar = false;
  


  Future<dynamic> obtenerEventos()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_publicity');
    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(url);
      final decoded = jsonDecode(respuesta.body);
      return decoded["Data"];  
    } catch (e) {
      return null;
    }


  }
  Future<dynamic> obtenerEventosCalendario(BuildContext context)async{
    
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/getAllEvents');
    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(url);
      final decoded = jsonDecode(respuesta.body);
      final lista = await Eventos.fromJsonList(decoded["fechaIniciales"], context);
    
      return lista;

    } catch (e) {
      return null;
    }

  }

  Future obtenerEventosPorFecha(String fecha) async {
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/getEventsByDate');
    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.post(
        url,
        body: {
          "fecha":fecha
        }
      );
      final decoded = jsonDecode(respuesta.body);
      // final lista = await Eventos.fromJsonList(decoded["fechaIniciales"], context);
      print(decoded["Data"]);
      return decoded["Data"];

    } catch (e) {
      return null;
    }
  }

}

