import 'package:flutter/material.dart';

class GaleriaProvider extends ChangeNotifier{

  String _pagina = '1';

  String get pagina{
    return this._pagina;
  }
  
  set pagina(String pagina){
    this._pagina = pagina;
    notifyListeners();
  }
}