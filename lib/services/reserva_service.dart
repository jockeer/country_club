import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/reserva_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';



import 'dart:io' show Platform;

class ReservaService{

  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();
  

  Future<bool> guardarReserva(Reserva reserva) async {
    

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
      print(decoded);
      
    } catch (e) {
      print(e);
      return null;
    }

  }




}

