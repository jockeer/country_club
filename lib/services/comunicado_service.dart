import 'dart:convert';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/providers/notificacion_provider.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:country/helpers/datos_constantes.dart';
import 'package:provider/provider.dart';

class ComunicadosService {
  final constantes = DatosConstantes();
  final prefs = PreferenciasUsuario();

  Future<List> obtenerComunicados(BuildContext context) async {
    final provider = Provider.of<NotificacionesProvider>(context);
    print(prefs.token);
    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/get_comunicados');

    final respuesta = await http.post(url, body: {"access_token": prefs.token});

    final decoded = await json.decode(respuesta.body);

    if (decoded.containsKey("error")) {
      prefs.token = '';
      mostrarSnackBar(context, 'Su sesión caduco inicie sesión nuevamente');
      Navigator.pushReplacementNamed(context, 'welcome');
      return [null];
    }
    provider.mensajesEnEspera = prefs.mensajesNuevos;
    print(decoded["Data"]);
    return decoded["Data"];
  }

  Future<List> obtenerComunicadosC() async {
    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/get_comunicados');

    final respuesta = await http.post(url, body: {"access_token": prefs.token});

    final decoded = await json.decode(respuesta.body);

    print(decoded["Data"]);
    return decoded["Data"];
  }
}
