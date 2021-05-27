import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{

  String _usuario = '';

  String _password = '';


  String get usuario{
    return this._usuario;
  }

  set usuario(String usuario){
    this._usuario = usuario;
    print("desde provider Lgoin: " + usuario);
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