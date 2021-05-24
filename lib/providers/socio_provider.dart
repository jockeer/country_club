import 'dart:async';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:country/models/socio_model.dart';

class SocioProvider{

  Future<Socio> getSocio(String codigoSocio) async {
    final n = num.tryParse(codigoSocio);

    if(n == null){
      return null;
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Asociado/GetDataID/$codigoSocio');

    final resp = await http.get( url );

    final decodedData = json.decode(resp.body);
    // print(decodedData[0]);

    if (decodedData.length == 0) {
      return null;
      
    }

    final socio = new Socio.fromJson(decodedData[0]);
    // print(socio.nombre);

    return socio;


  }

  Future<Socio> loginSocio(String usuario, String password) async {

    final n = num.tryParse(usuario);

    if(n==null){
      return null;
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Asociado/GetDataID/$usuario');

    final resp = await http.get( url );

    final decodedData = json.decode(resp.body);

    if (decodedData.length == 0) {
      return null;
      
    }
    final socio = new Socio.fromJson(decodedData[0]);

    return socio;

  }


}

