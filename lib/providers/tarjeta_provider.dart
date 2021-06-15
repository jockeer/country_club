
import 'package:flutter/material.dart';


class TarjetaProvider extends ChangeNotifier{

  int _optRecarga = 1;
  String _montoRecarga = '0';
  String _modoPago = '1';
  /*Ultimo pago*/

  String _detalle="";
  String _fecha="";
  String _idDeuda="";
  String _totalDeuda="";
  String _tipoDeuda="";


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

  /*Ultimo pago*/

  set detalle(String _detalle){
    this._detalle = _detalle;
    notifyListeners();
  }
  String get detalle{
    return this._detalle;
  }
  set fecha(String _fecha){
    this._fecha = _fecha;
    notifyListeners();
  }
  String get fecha{
    return this._fecha;
  }
  set idDeuda(String _idDeuda){
    this._idDeuda = _idDeuda;
    notifyListeners();
  }
  String get idDeuda{
    return this._idDeuda;
  }
  set totalDeuda(String _totalDeuda){
    this._totalDeuda = _totalDeuda;
    notifyListeners();
  }
  String get totalDeuda{
    return this._totalDeuda;
  }
  set tipoDeuda(String _tipoDeuda){
    this._tipoDeuda = _tipoDeuda;
    notifyListeners();
  }
  String get tipoDeuda{
    return this._tipoDeuda;
  }



}
