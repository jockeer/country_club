import 'package:flutter/material.dart';

class DisciplinaProvider extends ChangeNotifier{


  bool _menuAlto=false;

  int _banerTop = 0;

  Map<String, dynamic> _mensajePersonal;
  Map<String, dynamic> _mensajeGeneral;
  Map<String, dynamic> _mensajeALL;

  bool _todosup =false;
  bool _generalup =false;
  bool _personalup =false;

  bool _mostrar = false;

 

  Map<String, dynamic> get mensajePersonal{
    return this._mensajePersonal;
  }
  
  set mensajePersonal(Map<String, dynamic> mensajePersonal){
    this._mensajePersonal = mensajePersonal;
    notifyListeners();
  }
  Map<String, dynamic> get mensajeGeneral{
    return this._mensajeGeneral;
  }
  
  set mensajeGeneral(Map<String, dynamic> mensajeGeneral){
    this._mensajeGeneral = mensajeGeneral;
    notifyListeners();
  }
  Map<String, dynamic> get mensajeALL{
    return this._mensajeALL;
  }
  
  set mensajeALL(Map<String, dynamic> mensajeALL){
    this._mensajeALL = mensajeALL;
    notifyListeners();
  }
  bool get menuAlto{
    return this._menuAlto;
  }
  
  set menuAlto(bool menuAlto){
    this._menuAlto = menuAlto;
    notifyListeners();
  }
  bool get mostrar{
    return this._mostrar;
  }
  
  set mostrar(bool mostrar){
    this._mostrar = mostrar;
    notifyListeners();
  }

  int get banerTop{
    return this._banerTop;
  }
  
  set banerTop(int banerTop){
    this._banerTop = banerTop;
    notifyListeners();
  }

  bool get todosup{
    return this._todosup;
  }
  
  set todosup(bool todosup){
    this._todosup = todosup;
    notifyListeners();
  }

  bool get generalup{
    return this._generalup;
  }
  
  set generalup(bool generalup){
    this._generalup = generalup;
    notifyListeners();
  }

  bool get personalup{
    return this._personalup;
  }
  
  set personalup(bool personalup){
    this._personalup = personalup;
    notifyListeners();
  }
 
}