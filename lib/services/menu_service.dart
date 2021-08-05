

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:country/helpers/datos_constantes.dart';

class MenuService{

  final constantes = DatosConstantes();

  Future<List> obtenerMenu()async{

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_menu');

    final respuesta = await http.get(url);

    final decoded = await json.decode(respuesta.body);

    // print(decoded["Data"]);
    return decoded["Data"];
  }
}