import 'package:flutter/material.dart';


class ReservaProvider extends ChangeNotifier{

  String _codigoCab = '1';
  String _codigoSubCat;
  int _detalles = 0;

  String _fecha='';
  String _hora= "00:00";
  String _cantPersonas = '0';
  String _maxPersonas = '0';
  String _reqExtras='';
  String _telefono = '';
  String _nombre = '';
  String _destinatario = '1';
  String _motivoReserva = '';
  bool _terminos = false;
  bool _carga = false;

  set terminos(bool terminos){
    this._terminos = terminos;
    notifyListeners();
  }
  bool get terminos{
    return this._terminos;
  }
  set carga(bool carga){
    this._carga = carga;
    notifyListeners();
  }
  bool get carga{
    return this._carga;
  }
  set destinatario(String destinatario){
    this._destinatario = destinatario;
    notifyListeners();
  }
  String get destinatario{
    return this._destinatario;
  }
  set motivoReserva(String motivoReserva){
    this._motivoReserva = motivoReserva;
    notifyListeners();
  }
  String get motivoReserva{
    return this._motivoReserva;
  }
  set nombre(String nombre){
    this._nombre = nombre;
    notifyListeners();
  }
  String get nombre{
    return this._nombre;
  }
  set telefono(String telefono){
    this._telefono = telefono;
    notifyListeners();
  }
  String get telefono{
    return this._telefono;
  }
  set codigoCab(String codigoCab){
    this._codigoCab = codigoCab;
    notifyListeners();
  }
  String get codigoCab{
    return this._codigoCab;
  }

  set codigoSubCat(String codigoSubCat){
    this._codigoSubCat = codigoSubCat;
    notifyListeners();
  }
  String get codigoSubCat{
    return this._codigoSubCat;
  }

  set fecha(String fecha){
    this._fecha = fecha;
    notifyListeners();
  }
  String get fecha{
    return this._fecha;
  }

  set hora(String hora){
    this._hora = hora;
    notifyListeners();
  }
  String get hora{
    return this._hora;
  }
  set reqExtras(String reqExtras){
    this._reqExtras = reqExtras;
    notifyListeners();
  }
  String get reqExtras{
    return this._reqExtras;
  }

  set cantPersonas(String cantPersonas){
    this._cantPersonas = cantPersonas;
    notifyListeners();
  }
  String get cantPersonas{
    return this._cantPersonas;
  }
  set maxPersonas(String maxPersonas){
    this._maxPersonas = maxPersonas;
    notifyListeners();
  }
  String get maxPersonas{
    return this._maxPersonas;
  }
  set detalles(int detalles){
    this._detalles = detalles;
    notifyListeners();
  }
  int get detalles{
    return this._detalles;
  }
  

}