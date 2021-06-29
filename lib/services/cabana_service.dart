import 'dart:convert';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/cabana_model.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:http/http.dart' as http;

class CabanaService{

  final constantes = DatosConstantes();

  Future<List<Cabana>> obtenerCabanas()async{

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_cabanas');
    //print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return [null];
    }
    final respuesta = await http.get(url);

    final decoded = jsonDecode(respuesta.body);

    
    final cabanas = Cabanas.fromJsonList(decoded["Data"]);

    return cabanas.items;

  }
}