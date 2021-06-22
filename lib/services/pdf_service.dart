import 'dart:io';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfService{
  final constantes = DatosConstantes();
  
  Future<String> loadPDF(String pdf)async{

    final conexion = comprobarInternet();
    if (!conexion) {
      return null;
    }
    final url = Uri.https(constantes.dominio, pdf);
    final respuesta = await http.get(url);
    final dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/data.pdf");

    await file.writeAsBytes(respuesta.bodyBytes, flush: true);
    return file.path;
  }
}