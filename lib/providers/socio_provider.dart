import 'dart:async';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:country/models/socio_model.dart';
// import 'package:peliculas/src/models/pelicula_model.dart';

class SocioProvider{

  Future<Socio> _procesarRespuesta(Uri url) async{
    final resp = await http.get( url );
    
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);

    // final socio = Socio.fromJson(decodedData)
    
    // final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[0].title);
    

    // return peliculas.items;
  }

  Future<Socio> getSocio(String codigoSocio) async {

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


}

