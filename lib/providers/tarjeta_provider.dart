
import 'package:flutter/material.dart';


class TarjetaProvider extends ChangeNotifier{

  int _optRecarga = 1;
  String _montoRecarga = '0';
  String _modoPago = '1';


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

  set modoPago(String _modoPago){
    this._modoPago = _modoPago;
    notifyListeners();
  }
  String get modoPago{
    return this._modoPago;
  }


}
