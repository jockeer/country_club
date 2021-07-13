import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';

import 'package:country/utils/comprobar_conexion.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class ContactService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  bool cargar = false;
  

  Future<dynamic> obtenerContacto()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_contact_us');
    //print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.get(url);
      final decoded = jsonDecode(respuesta.body);
      return decoded;
      
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> enviarMensaje(String mensaje) async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/message_contact_us_customer');
    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    try {
      final respuesta = await http.post(
        url,
        body: {
          "message": mensaje,
          "access_token": prefs.token
        }
      );
      
      final decoded = json.decode(respuesta.body);
      return decoded;
    } catch (e) {
      return 0;
    }
  }
  
}

