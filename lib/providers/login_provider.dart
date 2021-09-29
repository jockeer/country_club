import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{

  String _usuario = '';

  String _password = '';

  String _mensajeAyuda = '';

  int _menu = 0;
  String _menuSelect;

  int _consumo = 0;


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

  int get menu{
    return this._menu;
  }

  set menu(int menu){
    this._menu = menu;
    notifyListeners();
  }
  String get menuSelect{
    return this._menuSelect;
  }

  set menuSelect(String menuSelect){
    this._menuSelect = menuSelect;
    notifyListeners();
  }
  int get consumo{
    return this._consumo;
  }

  set consumo(int consumo){
    this._consumo = consumo;
    notifyListeners();
  }
}