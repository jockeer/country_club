import 'package:country/services/tarjeta_service.dart';
import 'package:flutter/material.dart';


class TarjetaProvider extends ChangeNotifier{
  String _saldo = '0';

  set saldo(String saldo){
    this._saldo = saldo;
    notifyListeners();
  }

  Future<String> cargarDinero(String codigoSocio) async {
    final service = TarjetaService();
    final respuesta = await service.obtenerSaldo(codigoSocio);
    // notifyListeners();
    print(respuesta);
    this._saldo = respuesta;
    return this._saldo;
  }

}
