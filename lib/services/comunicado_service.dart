

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:country/helpers/datos_constantes.dart';

class ComunicadosService{

  final constantes = DatosConstantes();

  Future<List> obtenerComunicados()async{

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_comunicados');

    final respuesta = await http.get(url);

    final decoded = await json.decode(respuesta.body);

    print(decoded["Data"]);
    return decoded["Data"];
  }


}