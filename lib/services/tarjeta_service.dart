import 'dart:convert';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/models/detalle_compra_model.dart';
import 'package:country/models/deudas_model.dart';
import 'package:country/models/pagos_model.dart';
import 'package:country/utils/comprobar_conexion.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class TarjetaService {
  String user = 'Loyalty';
  String password = 'L0ya1tyc1ub5*';
  final prefs = PreferenciasUsuario();
  final constantes = DatosConstantes();

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
      return null;
    }
  }

  Future<String> obtenerSaldo(String codigoSocio) async {
    // print('consulta a la bd');

    final url = Uri.http(
        '190.186.228.218', 'appmovil/api/Tarjeta/GetCreditCardID/$codigoSocio');

    final respuesta = await _procesarInfo(url);
    if (respuesta == null) return null;

    return respuesta[0]["saldo"].toString();

    // return "450";
  }

  Future<List<Compra>> obtenerHistoricoCompras(String codigoSocio) async {
    // print('consulta a la bd');s

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    // final url = Uri.http('190.186.228.218', 'appmovil/api/Tarjeta/GetCardHistoryID/$codigoSocio');
    final url = Uri.http('190.186.228.218',
        'appmovil/api/Tarjeta/GetCardHistoryFullID/$codigoSocio');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    final compras = Compras.fromJsonList(respuesta);

    return compras.items;
  }

  Future<List<Compra>> obtenerHistoricoComprasEspecifico(
      String codigoSocio) async {
    // print('consulta a la bd');s

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218',
        'appmovil/api/Tarjeta/GetCardHistoryID/$codigoSocio');
    // final url = Uri.http('190.186.228.218', 'appmovil/api/Tarjeta/GetCardHistoryFullID/$codigoSocio');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    final compras = Compras.fromJsonList(respuesta);

    return compras.items;
  }

  Future<List<DetalleCompra>> obtenerDetalleCompra(String idVenta) async {
    // print('consulta a la bd');

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218',
        'appmovil/api/Tarjeta/GetCardHistoryDetailID/$idVenta');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    final detalles = Detalles.fromJsonList(respuesta);

    return detalles.items;

    // return compras.items;
  }

  Future<List<Pago>> obtenerHistoricoPagos() async {
    // print('consulta Historial pagos');

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218',
        'appmovil/api/Pagos/GetPaymentHistoryID/${prefs.codigoSocio}');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    final detalles = Pagos.fromJsonList(respuesta);

    return detalles.items;

    // return compras.items;
  }

  Future<List<Deuda>> obtenerHistoricoDeudas() async {
    // print('consulta Historial deudas');

    final conexion = await comprobarInternet();

    if (!conexion) {
      return [null];
    }

    final url = Uri.http('190.186.228.218',
        'appmovil/api/Deudas/GetDebtsHistoryID/${prefs.codigoSocio}');

    final respuesta = await _procesarInfo(url);

    if (respuesta == null) return null;

    final detalles = Deudas.fromJsonList(respuesta);

    return detalles.items;

    // return compras.items;
  }

  Future obtenerTokenPagos() async {
    final url = Uri.http(
        '190.186.228.218', 'appmovilcobro/api/SocioDigital/ObtenerToken');
    try {
      final token = await http.get(url, headers: {
        "authorization": basicAuthenticationHeader('country', '123456')
      });
      final tokenDecoded = await jsonDecode(token.body);
      return tokenDecoded;
    } catch (e) {
      return null;
    }
  }

  Future pagoLinkser(TarjetaCredito tarjeta, String monto) async {
    final url = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/Services/Linkser/pagoLinkser');
    final numeroTarjeta = tarjeta.cardNumber.replaceAll(' ', '');
    final fechas = tarjeta.expiracyDate.split('/');

    final parametros = {
      "numberCard": numeroTarjeta,
      "exp_mes": fechas[0],
      "exp_year": "20" + fechas[1],
      "monto": monto,
      "code": tarjeta.cvv,
      "nombre": prefs.nombreSocio,
      "apellido": prefs.apellidoSocio,
      "telefono": prefs.telefonoSocio,
      "correo": prefs.correoSocio
    };
    print(parametros);
    try {
      final respuesta = await http.post(
        url,
        body: parametros,
      );
      final respuestaDecoded = await jsonDecode(respuesta.body);
      return respuestaDecoded;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future recargarTarjeta(String monto, String codSocio, TarjetaCredito tarjeta,
      String glosa, String ci) async {
    // print(monto);
    // print(codSocio);
    // print(tarjeta);
    // print(glosa);
    // print(ci);
    // return;

    final conexion = await comprobarInternet();
    if (!conexion) return null;

    //Realizar pago en linker
    final linkser = await pagoLinkser(tarjeta, monto);
    if (linkser == null) {
      return null;
    }
    if (linkser["estadoPago"] != "AUTHORIZED") {
      print('error al registrar el pago');
      return null;
    }

    final urlLoyaly = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/recarga');

    final fecha = new DateTime.now();
    final transaccion = await http.post(urlLoyaly, body: {
      "codecli": prefs.codigoSocio,
      "fecha": fecha.toString(),
      "monto": monto.toString(),
      "access_token": prefs.token,
      "tipo": "abono"
    });
    print(fecha.toString());
    if (transaccion.statusCode != 200) {
      print('error al registrar en loyalty');
      return null;
    }
    final token = await obtenerTokenPagos();

    if (token == null) return null;

    if (token["codigo"] != 0) return null;

    final url =
        Uri.http('190.186.228.218', 'appmovilcobro/api/SocioDigital/Abonar');

    final fechaCountry = DateFormat('dd-MM-yyyy').format(fecha);
    final numeroTarjeta = tarjeta.cardNumber.replaceAll(' ', '');

    final dynamic parametros = {
      "CodigoSocio": int.parse(codSocio),
      "FechaAbono": "09/06/2021",
      "Moneda": 1,
      "Importe": double.parse(monto),
      "MetodoAbono": 1,
      "NroTarjeta": numeroTarjeta,
      "NroCI": ci,
      "NroAutorizacion": linkser["idPago"],
      "NroTransaccion": "",
      "Glosa": glosa
    };

    print(parametros);

    print("token :" + token["data"]);
    final rsp = await http.post(url, body: jsonEncode(parametros), headers: {
      "Authorization": 'Bearer ${token["data"]}',
      "Content-Type": 'application/json'
    });

    final respDecoded = await jsonDecode(rsp.body);
    if (respDecoded["CodigoRespuesta"] != 0) {
      print('error al recargar la tarjeta');
      return null;
    }

    print(respDecoded);

    return 0;
    // try {
    // } catch (e) {
    //   return null;
    // }
  }

  Future pagoMensualidad(
      String monto, TarjetaCredito tarjeta, String glosa, Deuda deuda) async {
    final conexion = await comprobarInternet();
    if (!conexion) return null;

    final linkser = await pagoLinkser(tarjeta, monto);
    if (linkser == null) {
      return null;
    }
    if (linkser["estadoPago"] != "AUTHORIZED") {
      print("error al pagar linkser");
      return null;
    }

    final urlLoyaly = Uri.parse(
        '${constantes.dominio}/laspalmas/ste/api-v1/customers/recarga');

    final fecha = new DateTime.now();
    final transaccion = await http.post(urlLoyaly, body: {
      "codecli": prefs.codigoSocio,
      "fecha": fecha.toString(),
      "monto": monto.toString(),
      "access_token": prefs.token,
      "tipo": "pago"
    });
    print(fecha.toString());
    if (transaccion.statusCode != 200) {
      print('error al insertar en loyalty');
      return null;
    }

    final token = await obtenerTokenPagos();

    if (token == null) return null;

    if (token["codigo"] != 0) return null;

    final url =
        Uri.http('190.186.228.218', 'appmovilcobro/api/SocioDigital/Pagar');

    final numeroTarjeta = tarjeta.cardNumber.replaceAll(' ', '');

    //final fecha = new DateTime.now();
    //final date = '${fecha.day}/${fecha.month}/${fecha.year}';

    final Map<String, dynamic> parametros = {
      "CodigoSocio": int.parse(prefs.codigoSocio),
      "FechaCobro": "09/06/2021",
      "Moneda": 1,
      "Importe": double.parse(monto),
      "TipoCambio": 6.96,
      "MetodoPago": 1,
      "NroTarjeta": numeroTarjeta,
      "NroCI": prefs.ciSocio,
      "NroAutorizacion": linkser["idPago"],
      "NroTransaccion": "",
      "Glosa": glosa,
      "Detalle": [
        {
          "Nrocxc": deuda.idDeuda,
          "ImporteCobrado": double.parse(monto),
          "Moneda": 1
        }
      ]
    };

    print(jsonEncode(parametros));

    final rsp = await http.post(url, body: jsonEncode(parametros), headers: {
      "Authorization": 'Bearer ${token["data"]}',
      "Content-Type": 'application/json'
    });

    final respDecoded = await jsonDecode(rsp.body);
    if (respDecoded["CodigoRespuesta"] != 0) {
      print('error al pagar la deuda');
      return null;
    }
    print(respDecoded);
    return 0;
  }
}
