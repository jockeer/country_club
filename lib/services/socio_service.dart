import 'dart:async';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/dependiente_model.dart';
import 'package:country/services/push_notificacion_service.dart';
import 'package:country/services/token_service.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:country/models/socio_model.dart';

import 'dart:io' show Platform;

class SocioService {
  String user = 'Loyalty';
  String password = 'L0ya1tyc1ub5*';
  final constantes = DatosConstantes();

  final tokenDevice = PushNotificationService();

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<dynamic> _procesarInfo(Uri url) async {
    try {
      final resp = await http.get(url, headers: {
        "authorization": basicAuthenticationHeader(user, password)
      });
      return json.decode(resp.body);
    } catch (e) {
      // print(e);
    }
  }

  Future<Socio> getSocio(String codigoSocio, String ci) async {
    final n = num.tryParse(codigoSocio);
    final ns = num.tryParse(ci);

    if (n == null || ns == null) {
      return null;
    }

    final url = Uri.http(
        '190.186.228.218', 'appmovil/api/Asociado/GetIDCI/$codigoSocio/$ci');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    if (respuesta[0]["error"] != "") return null;

    final url2 = Uri.http(
        '190.186.228.218', 'appmovil/api/Asociado/GetDataID/$codigoSocio');

    final decodedData = await _procesarInfo(url2);
    if (decodedData == null) return null;

    if (decodedData.length == 0) return null;

    final socio = new Socio.fromJson(decodedData[0]);

    return socio;
  }

  Future<List<Dependiente>> obtenerDependientes() async {
    final prefs = PreferenciasUsuario();
    final url = Uri.http('190.186.228.218',
        'appmovil/api/Asociado/GetDependentID/${prefs.codigoSocio}');

    final respuesta = await _procesarInfo(url);

    final dependiente = Dependientes.fromJsonList(respuesta);

    //print(dependiente.items[0]);
    return dependiente.items;
  }

  Future<Socio> loginSocio(String usuario, String pass) async {
    final prefs = PreferenciasUsuario();

    final n = num.tryParse(usuario);

    if (n == null) {
      return null;
    }
    try {
      final url = Uri.parse('${constantes.dominio}/laspalmas/oauth2/token');
      final respuesta = await http.post(url, body: {
        "password": pass,
        "grant_type": "password",
        "client_id": "LASPALMASAppUser",
        "username": usuario
      });
      final decodedData = jsonDecode(respuesta.body);

      if (decodedData.containsKey("access_token")) {
        prefs.token = await decodedData["access_token"];
        final _tokenService = TokenService();

        await tokenDevice.obtenerDeviceToken();

        final devideTokenguardado = await _tokenService.registrarDeviceToken();
        if (devideTokenguardado) {
          final socio = await obtenerDatosSocio();
          return socio;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Socio> obtenerDatosSocio() async {
    final prefs = PreferenciasUsuario();

    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/services/get_customer?access_token=${prefs.token}');

    final respuesta = await http.get(url);

    final decodedData = jsonDecode(respuesta.body);

    final socio = Socio.fromJson(decodedData["Data"]);

    return socio;
  }

  Future<dynamic> registrarSocio(Socio socio) async {
    final prefs = PreferenciasUsuario();

    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/customers');
    final urlCountry = Uri.http('190.186.228.218',
        'appmovil/api/Asociado/SetTelCelDirID/${socio.codigo}/${socio.telefono}/${socio.celular}/${socio.direccion}/${socio.email}');

    final parametros = socio.toJson();

    parametros["access_token"] = await prefs.tokenReg;
    parametros["type"] = (Platform.isAndroid) ? "ANDROID" : "IOS";

    try {
      final respuesta = await _procesarInfo(urlCountry);
      print(respuesta);
    } catch (e) {
      print("No actualizo datos del country");
    }
    // print(parametros);
    try {
      final respuesta = await http.post(url, body: parametros);
      // final registroCountry = await _procesarInfo(url);

      // print(registroCountry);

      final resp = await json.decode(respuesta.body);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> recoverPassword(String email) async {
    final prefs = PreferenciasUsuario();
    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/validate_email');

    try {
      final respuesta = await http
          .post(url, body: {"email": email, "access_token": prefs.tokenReg});
      final decoded = json.decode(respuesta.body);
      return decoded;
    } catch (e) {
      return null;
    }
  }
}
