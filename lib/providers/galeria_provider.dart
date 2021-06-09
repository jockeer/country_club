import 'package:flutter/material.dart';

class GaleriaProvider extends ChangeNotifier{

  String _pagina = '1';

  String _galeria = 'palmeras';

  String get pagina{
    return this._pagina;
  }
  
  set pagina(String pagina){
    this._pagina = pagina;
    notifyListeners();
  }
  String get galeria{
    return this._galeria;
  }
  
  set galeria(String galeria){
    this._galeria = galeria;
    notifyListeners();
  }
}