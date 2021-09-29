import 'package:flutter/material.dart';

class EventosProvider extends ChangeNotifier{


  String _fechaElegida="";

 

  String get fechaElegida{
    return this._fechaElegida;
  }
  
  set fechaElegida(String fechaElegida){
    this._fechaElegida = fechaElegida;
    notifyListeners();
  }
 
}