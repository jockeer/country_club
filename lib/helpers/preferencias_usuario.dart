

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

  get codigoSocio{
    return _prefs.getString('codigo') ?? 'sin codigo';
  }

  set codigoSocio(String codigo){
    _prefs.setString('codigo', codigo);
  }
  //GET Y SET del Nombre de Socio

  get telefonoSocio{
    return _prefs.getString('telefono') ?? 'sin telefono';
  }

  set telefonoSocio(String telefono){
    _prefs.setString('telefono', telefono);
  }
  get ciSocio{
    return _prefs.getString('ci') ?? 'sin ci';
  }

  set ciSocio(String ci){
    _prefs.setString('ci', ci);
  }
  //GET Y SET del Nombre de Socio

  get nombreSocio{
    return _prefs.getString('nombre') ?? 'sin nombre';
  }

  set nombreSocio(String nombre){
    _prefs.setString('nombre', nombre);
  }
  get apellidoSocio{
    return _prefs.getString('apellido') ?? 'sin apellido';
  }

  set apellidoSocio(String apellido){
    _prefs.setString('apellido', apellido);
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
    return _prefs.getString('token') ?? '';
  }

  set token(String token){
    _prefs.setString('token', token);
  }
  //GET Y SET del Token de usuario
  get tokenReg{
    return _prefs.getString('tokenReg') ?? 'sin token';
  }

  set tokenReg(String token){
    _prefs.setString('tokenReg', token);
  }

  //GET Y SET del token del telefono
  get deviceToken{
    return _prefs.getString('deviceToken') ?? 'sin deviceToken';
  }

  set deviceToken(String deviceToken){
    _prefs.setString('deviceToken', deviceToken);
  }

  /* para las notificaciones de usuario*/
  get notificacionEnCola{
    return _prefs.getStringList('notificacion') ?? [] ;
  }
  set notificacionEnCola(List<String> notificacionEnCola){
    _prefs.setStringList('notificacion',notificacionEnCola);
  }

  get mensajesNuevos{
    return _prefs.getInt('news') ?? 0 ;
  }
  set mensajesNuevos(int mensajesNuevos){
    _prefs.setInt('news', mensajesNuevos);
  }
}