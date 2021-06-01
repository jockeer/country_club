import 'dart:async';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:country/models/socio_model.dart';

class SocioService{

  String user = 'Loyalty';
  String password = 'L0ya1tyc1ub5*';

  
  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<dynamic> _procesarInfo(Uri url) async{
    try {
      final resp = await http.get(url,
        headers: {
          "authorization": basicAuthenticationHeader(user, password)
        }
      );
      return json.decode(resp.body);
      
    } catch (e) {
      print(e);
    }
  }

  Future<Socio> getSocio(String codigoSocio, String ci) async {
    final n = num.tryParse(codigoSocio);

    if(n == null){
      return null;
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Asociado/GetIDCI/$codigoSocio/$ci');

    final respuesta = await _procesarInfo(url);

    if(respuesta == null)return null;

    if (respuesta[0]["error"] != "") return null;


    final url2 = Uri.http('190.186.228.218', 'appmovil/api/Asociado/GetDataID/$codigoSocio');
    
    final decodedData = await _procesarInfo(url2);
     if(decodedData == null)return null;

    if (decodedData.length == 0) return null;
      

    final socio = new Socio.fromJson(decodedData[0]);

    return socio;
    


  }

  Future<Socio> loginSocio(String usuario, String pass) async {

    final n = num.tryParse(usuario);

    if(n==null){
      return null;
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Asociado/GetDataID/$usuario');


    final decodedData = await _procesarInfo(url);

    if(decodedData == null)return null;

    if (decodedData.length == 0 || decodedData == null) {
      return null;
    }
    final socio = new Socio.fromJson(decodedData[0]);

    return socio;

  }


}

