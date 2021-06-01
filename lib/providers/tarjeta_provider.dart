import 'package:country/services/tarjeta_service.dart';
import 'package:flutter/material.dart';


class TarjetaProvider extends ChangeNotifier{

  int _optRecarga = 1;
  String _montoRecarga = '0';


  set montoRecarga(String _montoRecarga){
    this._montoRecarga = _montoRecarga;
    notifyListeners();
  }
  String get montoRecarga{
    return this._montoRecarga;
  }
  set optRecarga(int _optRecarga){
    this._optRecarga = _optRecarga;
    notifyListeners();
  }
  int get optRecarga{
    return this._optRecarga;
  }

  Future<String> cargarDinero(String codigoSocio) async {
    final service = TarjetaService();
    final respuesta = await service.obtenerSaldo(codigoSocio);
    print(respuesta);
    return respuesta;
  }

}
