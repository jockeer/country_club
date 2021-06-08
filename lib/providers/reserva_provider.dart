import 'package:flutter/material.dart';


class ReservaProvider extends ChangeNotifier{

  String _codigoCab = '1';
  String _codigoSubCat;

  String _fecha='';
  String _hora= "00:00";
  String _cantPersonas = '0';
  String _reqExtras='';
  String _telefono = '';
  String _nombre = '';
  bool _carga = false;

  set carga(bool carga){
    this._carga = carga;
    notifyListeners();
  }
  bool get carga{
    return this._carga;
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
  

}