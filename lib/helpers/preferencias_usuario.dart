

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance(); 
  }

  //GET Y SET del Nombre de Socio

  get nombreSocio{
    return _prefs.getString('nombre') ?? 'sin nombre';
  }

  set nombreSocio(String nombre){
    _prefs.setString('nombre', nombre);
  }

  //GET Y SET del Correo de Socio
  get correoSocio{
    return _prefs.getString('correo') ?? 'sin correo';
  }

  set correoSocio(String correo){
    _prefs.setString('correo', correo);
  }

  //GET Y SET del Token de usuario
  get token{
    return _prefs.getString('token') ?? 'sin token';
  }

  set token(String token){
    _prefs.setString('token', token);
  }

  
}