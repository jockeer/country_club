
import 'package:country/models/deudas_model.dart';
import 'package:flutter/material.dart';


class TarjetaProvider extends ChangeNotifier{

  int _optRecarga = 1;
  String _montoRecarga = '10.00';
  String _modoPago = '1';

  String _codigoTarjeta='';
  String _dependiente='';
  /*Ultimo pago*/

  String _detalle="";
  String _fecha="";
  String _idDeuda="";
  String _totalDeuda="";
  String _tipoDeuda="";
  int _tipoPago = 0;
  
  Deuda _deuda;


  set deuda(Deuda _deuda){
    this._deuda = _deuda;
    notifyListeners();
  }
  Deuda get deuda{
    return this._deuda;
  }

  set dependiente(String _dependiente){
    this._dependiente = _dependiente;
    notifyListeners();
  }
  String get dependiente{
    return this._dependiente;
  }
  set codigoTarjeta(String _codigoTarjeta){
    this._codigoTarjeta = _codigoTarjeta;
    notifyListeners();
  }
  String get codigoTarjeta{
    return this._codigoTarjeta;
  }
  set montoRecarga(String _montoRecarga){
    this._montoRecarga = _montoRecarga;
    notifyListeners();
  }
  String get montoRecarga{
    return this._montoRecarga;
  }

  set tipoPago(int _tipoPago){
    this._tipoPago = _tipoPago;
    notifyListeners();
  }
  int get tipoPago{
    return this._tipoPago;
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
