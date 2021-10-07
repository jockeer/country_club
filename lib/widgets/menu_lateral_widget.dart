import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

class MenuLateralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colores = ColoresApp();

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(top: 30, left: 8, right: 10),
        width: 100,
        decoration: BoxDecoration(
            color: colores.verdeOscuro,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        // height: phoneSize.height*0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _MenuItem(
                icon: 'disciplinamenu.png',
                titulo: 'DISCIPLINAS',
                ruta: 'disciplinas',
              ),
              _MenuItem(
                icon: 'horariomenu.png',
                titulo: 'HORARIOS',
                ruta: 'horarios',
              ),
              _MenuItem(
                icon: 'mensualidadmenu.png',
                titulo: 'MENSUALIDAD',
                ruta: 'mensualidad',
              ),
              _MenuItem(
                icon: 'tarjetamenu.png',
                titulo: 'TARJETA CONSUMO',
                ruta: 'historico_tarjeta',
              ),
              _MenuItem(
                icon: 'comunicadosmenu.png',
                titulo: 'COMUNICADOS',
                ruta: 'comunicados',
              ),
              _MenuItem(
                icon: 'reservasmenu.png',
                titulo: 'RESERVAS',
                ruta: 'reservas',
              ),
              _MenuItem(
                icon: 'emailmenu.png',
                titulo: 'E-MAILS',
                ruta: 'inbox',
              ),
              _MenuItem(
                icon: 'menumenu.png',
                titulo: 'MENÚ RESTAURANTE',
                ruta: 'menu',
              ),
              _MenuItem(
                icon: 'eventosmenu.png',
                titulo: 'EVENTOS',
                ruta: 'eventos',
              ),
              _MenuItem(
                icon: 'soportemenu.png',
                titulo: 'SOPORTE',
                ruta: 'contact',
              ),
              _MenuItem(
                icon: 'soportemenu.png',
                titulo: 'CERRAR SESIÓN',
                ruta: 'welcome',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String titulo, ruta, icon;
  _MenuItem({@required this.titulo, @required this.ruta, @required this.icon});
  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, this.ruta);
            },
            child: (ruta == 'welcome')
                ? Center(
                    child: Icon(
                    Icons.logout,
                    size: 25,
                    color: colores.verdeMenuLateral,
                  ))
                : Image(
                    image: AssetImage('assets/icons/$icon'),
                    width: 25,
                  )),
        SizedBox(
          height: 5,
        ),
        Text(
          this.titulo,
          style: TextStyle(
              color: colores.verdeMenuLateral, fontSize: size.width * 0.024),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
