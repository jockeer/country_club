
import 'dart:convert';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/models/detalle_compra_model.dart';
import 'package:country/models/deudas_model.dart';
import 'package:country/models/pagos_model.dart';
import 'package:country/utils/comprobar_conexion.dart';
import "package:http/http.dart" as http;

class TarjetaService {

  String user = 'Loyalty';
  String password = 'L0ya1tyc1ub5*';
  final prefs = PreferenciasUsuario();


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
      return null;
    }
  }


  Future<String> obtenerSaldo(String codigoSocio) async{
    // print('consulta a la bd');

    final url = Uri.http('190.186.228.218', 'appmovil/api/Tarjeta/GetCreditCardID/$codigoSocio');

    final respuesta = await _procesarInfo(url);
     if(respuesta == null)return null;
    
 
    return respuesta[0]["saldo"].toString();
    
    // return "450";
  }
  Future<List<Compra>> obtenerHistoricoCompras(String codigoSocio) async{
    // print('consulta a la bd');

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Tarjeta/GetCardHistoryID/$codigoSocio');

    final respuesta = await _procesarInfo(url);
    
     if(respuesta == null)return null;

    final compras = Compras.fromJsonList(respuesta);

    return compras.items;
  
  }


  Future<List<DetalleCompra>> obtenerDetalleCompra(String idVenta) async{
      // print('consulta a la bd');

      final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

      final url = Uri.http('190.186.228.218', 'appmovil/api/Tarjeta/GetCardHistoryDetailID/$idVenta');

      final respuesta = await _procesarInfo(url);
    
     if(respuesta == null)return null;

      final detalles = Detalles.fromJsonList(respuesta);

      return detalles.items;

    // return compras.items;
  
  }
  Future<List<Pago>> obtenerHistoricoPagos() async{
      // print('consulta Historial pagos');

      final conexion = await comprobarInternet();
      

    if (!conexion) {
      return [null];
    }

      final url = Uri.http('190.186.228.218', 'appmovil/api/Pagos/GetPaymentHistoryID/${prefs.codigoSocio}');

      final respuesta = await _procesarInfo(url);
    
     if(respuesta == null)return null;

      final detalles = Pagos.fromJsonList(respuesta);

      return detalles.items;

    // return compras.items;
  
  }

  Future<List<Deuda>> obtenerHistoricoDeudas() async{
    // print('consulta Historial deudas');

    final conexion = await comprobarInternet();
      
    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218', 'appmovil/api/Deudas/GetDebtsHistoryID/${prefs.codigoSocio}');

    final respuesta = await _procesarInfo(url);
    
    if(respuesta == null)return null;

    final detalles = Deudas.fromJsonList(respuesta);

    return detalles.items;

    // return compras.items;
  
  }

  Future obtenerTokenPagos()async{
    final url = Uri.http('190.186.228.218', 'appmovilcobro/api/SocioDigital/ObtenerToken');
    try {
      final token = await http.get(
          url,
          headers: {
            "authorization": basicAuthenticationHeader('country', '123456')
          }
        );
        final tokenDecoded = await jsonDecode(token.body);
        return tokenDecoded;
      
    } catch (e) {
      return null;
    }
  }

  Future recargarTarjeta(String monto,String codSocio,TarjetaCredito tarjeta, String glosa) async {

    final conexion = await comprobarInternet();
    if (!conexion) return null;

    final token = await obtenerTokenPagos();

    if (token == null)return null; 

    if (token["codigo"] != 0) return null;


    final url = Uri.http('190.186.228.218', 'appmovilcobro/api/SocioDigital/Abonar');

    // final fecha = new DateTime.now();
    // final date = '${fecha.day}/${fecha.month}/${fecha.year}';
    final numeroTarjeta = tarjeta.cardNumber.replaceAll(' ', '');

    final dynamic parametros = {
      "CodigoSocio":int.parse(codSocio),
      "FechaAbono":"09/06/2021",
      "Moneda":1,
      "Importe":double.parse(monto),
      "MetodoAbono":1,
      "NroTarjeta":numeroTarjeta,
      "NroCI":prefs.ciSocio,
      "NroAutorizacion":"15",
      "NroTransaccion":"",
      "Glosa":glosa
    };

    print(parametros);

    //print("token :" + token["data"]);
    final rsp = await http.post(
      url,
      body: jsonEncode(parametros),
      headers:{
        "Authorization" : 'Bearer ${token["data"]}',
        "Content-Type" : 'application/json'
      } 
    );


    final respDecoded = await jsonDecode(rsp.body);
    if (respDecoded["CodigoRespuesta"] != 0) return null;
    
    return 0;
    // try {
    // } catch (e) {
    //   return null;
    // }
  }

  Future pagoMensualidad(String monto,String codigoSocio,TarjetaCredito tarjeta, String glosa) async {

    final conexion = await comprobarInternet();
    if (!conexion) {
      return null;
    }

    final fecha = new DateTime.now();
    //final url = Uri.http('190.186.228.218', 'appmovil/api/SocioDigital/Abonar');
    //print('${fecha.day}/${fecha.month}/${fecha.year}');
    final date = '${fecha.day}/${fecha.month}/${fecha.year}';

    final parametros = {
      "CodigoSocio": int.parse(codigoSocio),
      "FechaCobro": date,
      "Moneda": 1,
      "Importe": double.parse(monto),
      "TipoCambio": "",
      "MetodoPago": 1,
      "NroTarjeta" : tarjeta.cardNumber,
      "NroCI": prefs.ciSocio,
      "NroAutorizacion":"",
      "NroTransaccion":"",
      "Glosa":glosa,
    };

    print(parametros);
    // try {
    
    //   final respuesta = await http.post(
    //     url,
    //     body: {
    //       "CodigoSocio": int.parse(prefs.codigoSocio),
    //       "FechaAbono": date,
    //       "Moneda": 1,
    //       "Importe": int.parse(monto),
    //       "MetodoAbono": 1,
    //       "NroTarjeta" : tarjeta.cardNumber,
    //       "NroCI": prefs.ciSocio,
    //       "NroAutorizacion":"",
    //       "NroTransaccion":"",
    //       "Glosa":"",

    //     }
    //   );
    // } catch (e) {
    // }
  }

}