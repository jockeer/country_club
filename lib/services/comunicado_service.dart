

import 'dart:convert';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:country/helpers/datos_constantes.dart';

class ComunicadosService{

  final constantes = DatosConstantes();
  final prefs= PreferenciasUsuario();

  Future<List> obtenerComunicados( BuildContext context)async{
    
    print(prefs.token);
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/customers/get_comunicados');

    final respuesta = await http.post(
      url,
      body: {
        "access_token": prefs.token
      }
    );

    final decoded = await json.decode(respuesta.body);

    if (decoded.containsKey("error")) {
      mostrarSnackBar(context, 'Su sesión caduco inicie sesión nuevamente');
      Navigator.pushReplacementNamed(context, 'welcome');
      return [null];
    }
    print(decoded["Data"]);
    return decoded["Data"];
  }


}