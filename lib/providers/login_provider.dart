import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{

  String _usuario = '';

  String _password = '';

  String _mensajeAyuda = '';


  String get mensajeAyuda{
    return this._mensajeAyuda;
  }

  set mensajeAyuda(String mensajeAyuda){
    this._mensajeAyuda = mensajeAyuda;
    notifyListeners();
  }
  String get usuario{
    return this._usuario;
  }

  set usuario(String usuario){
    this._usuario = usuario;
    notifyListeners();
  }

  String get password{
    return this._password;
  }

  set password(String password){
    this._password = password;
    notifyListeners();
  }
}