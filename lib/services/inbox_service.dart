import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';

import 'package:country/utils/comprobar_conexion.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class InboxService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  bool cargar = false;
  

  Future<dynamic> obtenerAllMensajes()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/getAllMensaje?access_token=${prefs.token}');
    //print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(
        url
      );
      final decoded = jsonDecode(respuesta.body);
      return decoded["Data"];
      
    } catch (e) {
      return null;
    }
  }
  Future<dynamic> obtenerMensajesPersonales()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/getMensajePersonales?access_token=${prefs.token}');
    //print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(
        url
      );
      final decoded = jsonDecode(respuesta.body);
      return decoded["Data"];
      
    } catch (e) {
      return null;
    }
  }
  Future<dynamic> obtenerMensajesGenerales()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/getMensajeGenerales');
    //print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(
        url
      );
      final decoded = jsonDecode(respuesta.body);
      return decoded["Data"];
      
    } catch (e) {
      return null;
    }
  }

  
}

