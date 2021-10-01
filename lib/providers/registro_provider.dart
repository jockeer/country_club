import 'package:flutter/material.dart';

class RegistroProvider extends ChangeNotifier{

  String _codigo  = '';  

  String _ci = '';
  String _origen= '';
  String _direccion= '';
  String _codtel = '+591';
  String _telefono = '';
  String _celular = '';

  String _email = '';
  String _password = '';

  bool _carga= false;

  bool _terminos = false;

  bool get terminos{
    return this._terminos;
  }

  set terminos(bool terminos){
    this._terminos = terminos;
    notifyListeners();
  }
  bool get carga{
    return this._carga;
  }

  set carga(bool carga){
    this._carga = carga;
    notifyListeners();
  }
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
  String get celular{
    return this._celular;
  }

  set celular(String celular){
    this._celular = celular;
    notifyListeners();
  }

  String get direccion{
    return this._direccion;
  }

  set direccion(String direccion){
    this._direccion = direccion;
    notifyListeners();
  }

}