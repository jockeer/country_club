import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class ReservaService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  

  Future<dynamic> guardarReserva(Reserva reserva) async {
    

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/customers/reserva');

    final paremetros = reserva.toJson();
    paremetros["access_token"]= await prefs.token;
    // print(paremetros);

    try {
      final respuesta = await http.post(
        url,
        body: paremetros
      );
      
      final decoded = jsonDecode(respuesta.body);
      return decoded;
      
    } catch (e) {
      print(e);
      return null;
    }

  }
  Future<List<Reserva>> obtenerReservas()async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_all_reservas?access_token=${prefs.token}');
    // print(url); 

    final conexion = await comprobarInternet();
    if (!conexion) {
      return [null];
    }
    final respuesta = await http.get(url);

    final decoded = jsonDecode(respuesta.body);

    final reservas = Reservas.fromJsonList(decoded["Data"]);

    return reservas.items;

    // print(decoded);
  }
  Future<bool> cancelarReserva(String idReserva)async{
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/get_cancelar_reserva?access_token=${prefs.token}&id_reserva=${int.parse(idReserva)}');
    // print(url); 
    final respuesta = await http.get(url);

    final decoded = jsonDecode(respuesta.body);

    print(decoded);
    return decoded["Status"];

    // print(decoded);
  }




}

