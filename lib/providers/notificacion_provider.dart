import 'package:flutter/material.dart';

class NotificacionesProvider extends ChangeNotifier{

  String _titulo;

  String get titulo{
    return this._titulo;
  }

  set titulo(String titulo){
    this._titulo = titulo;
    notifyListeners();
  }

}