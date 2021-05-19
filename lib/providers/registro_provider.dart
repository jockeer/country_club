import 'package:flutter/material.dart';

class RegistroProvider extends ChangeNotifier{

  int _codigo  = 1;  
  String _apPaterno = '';
  String _apMaterno= '';
  String _nombre= '';
  int _ci = 0;
  String _origen= '';
  String _direccion= '';
  String _telefono= '';

  int get codigo{
    return this._codigo;
  }

  set codigo(int codigo){
    this._codigo = codigo;
    notifyListeners();
  }

}