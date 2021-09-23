import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';


class MainMenuPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawerScrimColor:Colors.transparent,
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Image(image: AssetImage('assets/backgrounds/fondo_menu.jpg')),
              _MenuPrincipal()
            ],
          ),
        )
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Icon(Icons.menu, color: Colors.white,),
            onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Container(child: Text('Hola ${prefs.nombreSocio}!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:Radius.circular(50) ),
        child: Container(
          height: size.height*0.65,
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OpcionMenu(titulo: 'DISCIPLINAS', icono: 'disciplinas.png', ruta: 'disciplinas' ),
                  _OpcionMenu(titulo: 'HORARIOS', icono: 'horarios.png', ruta: 'eventos' ),
                  _OpcionMenu(titulo: 'MENSUALIDAD', icono: 'mensualidad.png', ruta: 'mensualidad' ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OpcionMenu(titulo: 'MENÚ RESTAURANT', icono: 'menu.png', ruta: 'menu' ),
                  _OpcionMenu(titulo: 'TARJETA CONSUMO', icono: 'tarjeta.png', ruta: 'tarjeta' ),
                  _OpcionMenu(titulo: 'RESERVAS', icono: 'reservas.png', ruta: 'reservas' ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OpcionMenu(titulo: 'EVENTOS', icono: 'eventos.png', ruta: 'eventos' ),
                  _OpcionMenu(titulo: 'COMUNICADOS', icono: 'comunicados.png', ruta: 'eventos' ),
                  _OpcionMenu(titulo: 'E-MAILS', icono: 'email.png', ruta: 'inbox' ),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class _OpcionMenu extends StatelessWidget {
  final String titulo, icono, ruta;
  final colores= ColoresApp();
  _OpcionMenu({ @required this.titulo, @required this.icono, @required this.ruta });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.3,
      // height: size.width*0.3,
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, this.ruta);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image( image: AssetImage('assets/icons/$icono'), width: size.width*0.135,),
            SizedBox(height: 10,),
            Text( this.titulo, style: TextStyle( fontSize: size.width*0.038, fontWeight: FontWeight.w500, color: colores.verde),maxLines: 2,textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
