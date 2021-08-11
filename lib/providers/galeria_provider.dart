import 'package:flutter/material.dart';

class GaleriaProvider extends ChangeNotifier{

  String _pagina = '1';

  String _cantPaginas = '0';

  String _galeria = 'palmeras';

  int _tituloExtra = 1;

  String get cantPaginas{
    return this._cantPaginas;
  }
  
  set cantPaginas(String cantPaginas){
    this._cantPaginas = cantPaginas;
    notifyListeners();
  }
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

  
  int get tituloExtra{
    return this._tituloExtra;
  }
  
  set tituloExtra(int tituloExtra){
    this._tituloExtra = tituloExtra;
    notifyListeners();
  }
}