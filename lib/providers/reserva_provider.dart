import 'package:flutter/material.dart';


class ReservaProvider extends ChangeNotifier{

  String _codigoCat = '1';
  String _codigoSubCat;

  String _fecha='';
  String _hora= "00:00";
  String _cantPersonas = '0';
  String _reqExtras='';

  set codigoCat(String codigoCat){
    this._codigoCat = codigoCat;
    notifyListeners();
  }
  String get codigoCat{
    return this._codigoCat;
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