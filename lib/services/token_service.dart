import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';

class TokenService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  
  Future<String> obtenerToken() async {

    final url = Uri.https(constantes.dominio, 'laspalmas/web/Token/Token');
    try {
      final respuesta = await http.post(
        url,
        body: {
          "client_id"     : "LASPALMASApp",
          "client_secret" : "ZjUxNjY3NzFkYjY0NTg2NjJhY2RiOTg0Njg2NGM4ZDg"
        }
      );

      if(respuesta.statusCode == 500) return "";
      final token = json.decode(respuesta.body);

      prefs.token = token["access_token"].toString();

      // print(token["access_token"].toString());
      return "ok";
      
    } catch (e) {
      print(e);
      return "";
    }
    
  }

  Future<bool> registrarDeviceToken()async{
    
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/Services/Notification');

    try {
      final respuesta = await http.post(
        url,
        body: {
          "grant_type": "password",
          "client_id": "LASPALMASApp",
          "access_token": prefs.token,
          "device_type": (Platform.isAndroid)?'ANDROID':'IOS',
          "device_token": prefs.deviceToken
        }
      );
      if (respuesta.statusCode==200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }

  }

}