import 'dart:async';
import 'dart:io';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfService{
  final constantes = DatosConstantes();
  
  Future<dynamic> loadPDF(String pdf)async{

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }
    Completer<File> completer = Completer();
    try {
      final filename = pdf.substring(pdf.lastIndexOf("/") + 1);
      var request = await http.get(Uri.parse(pdf));
      var bytes = request.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      return completer.future;
    } catch (e) {
        return "error"; 
    }
    
  }


  Future<File> reglamento(String asset)async{
    try {
      var data =await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/reglamento.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;


    } catch (e) {
      throw Exception("Error opening asset file");
    }



    }
  Future<File> terminos(String asset)async{
    try {
      var data =await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/terminos.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;


    } catch (e) {
      throw Exception("Error opening asset file");
    }



    }
}