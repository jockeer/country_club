import 'dart:convert';

import 'package:country/helpers/datos_constantes.dart';
import 'package:http/http.dart' as http;

class DisciplinasService {
  final constantes = DatosConstantes();
  Future obtenerDisciplinas () async{

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/obenterDisciplinas');

    final resp = await http.get(url);

    final respDecoded = await jsonDecode(resp.body);

    print(respDecoded);
    return respDecoded["Data"];


  }
  Future obtenerSubDisciplinas (int idPadre) async{

    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/obenterSubDisciplinas');

    final resp = await http.post(
      url,
      body: {
        "idPadre":idPadre.toString()
      }
    );

    final respDecoded = await jsonDecode(resp.body);

    print(respDecoded);
    return respDecoded["Data"];


  }

  Future obetenerProfesores(String id) async {
    final url = Uri.https(constantes.dominio, 'laspalmas/ste/api-v1/services/profesoresPorDisciplina?id=${int.parse(id)}');
    final resp = await http.get(url);

    final respDecoded = await jsonDecode(resp.body);

    print(respDecoded);
    return respDecoded["Data"];
  }

}