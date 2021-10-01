import 'package:flutter/material.dart';

class DisciplinaProvider extends ChangeNotifier{


  bool _menuAlto=false;

  int _banerTop = 0;

 

  bool get menuAlto{
    return this._menuAlto;
  }
  
  set menuAlto(bool menuAlto){
    this._menuAlto = menuAlto;
    notifyListeners();
  }

  int get banerTop{
    return this._banerTop;
  }
  
  set banerTop(int banerTop){
    this._banerTop = banerTop;
    notifyListeners();
  }
 
}