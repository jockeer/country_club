import 'package:flutter/material.dart';

class RegistroProvider extends ChangeNotifier{

  String _codigo  = '';  

  String _ci = '';
  String _origen= '';
  // String _direccion= '';
  String _codtel = '+591';
  String _telefono = '';

  String _email = '';
  String _password = '';

  String get codigo{
    return this._codigo;
  }

  set codigo(String codigo){
    this._codigo = codigo;
    notifyListeners();
  }

  String get email{
    return this._email;
  }

  set email(String email){
    this._email = email;
    notifyListeners();
  }
  String get password{
    return this._password;
  }

  set password(String password){
    this._password = password;
    notifyListeners();
  }

  String get ci{
    return this._ci;
  }

  set ci(String ci){
    this._ci = ci;
    notifyListeners();
  }
  String get origen{
    return this._origen;
  }

  set origen(String origen){
    this._origen = origen;
    notifyListeners();
  }
  String get codtel{
    return this._codtel;
  }

  set codtel(String codtel){
    this._codtel = codtel;
    notifyListeners();
  }
  String get telefono{
    return this._telefono;
  }

  set telefono(String telefono){
    this._telefono = telefono;
    notifyListeners();
  }

}