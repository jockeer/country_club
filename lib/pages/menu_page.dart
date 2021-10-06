import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          appBarWidget(titulo: 'MENÚ', color: Colors.white, texto: Colors.grey, logoClaro: true),
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Container(
                    width: size.width,
                    height: size.height * 0.85,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        _MenuItem(
                          foto: 'desayunos.jpg',
                          titulo: 'DESAYUNO',
                          cat: 0,
                        ),
                        _MenuItem(
                          foto: 'rapida.jpg',
                          titulo: 'COMIDA RAPIDA',
                          cat: 8,
                        ),
                        _MenuItem(
                          foto: 'entradas.jpg',
                          titulo: 'ENTRADAS',
                          cat: 1,
                        ),
                        _MenuItem(
                          foto: 'principal.jpg',
                          titulo: 'PLATO PRINCIPAL',
                          cat: 3,
                        ),
                        _MenuItem(
                          foto: 'postres.jpg',
                          titulo: 'POSTRES',
                          cat: 11,
                        ),
                        _MenuItem(
                          foto: 'pernil.png',
                          titulo: 'CATERING',
                          cat: 5,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      )
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String foto, titulo;
  final int cat;

  _MenuItem({@required this.foto, @required this.titulo, @required this.cat});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        provider.menu = this.cat;
        provider.menuSelect = (cat == 0
            ? 'desayuno.jpg'
            : cat == 8
                ? 'sandwich.jpg'
                : cat == 1
                    ? 'sopas.jpg'
                    : cat == 3
                        ? 'pastas.jpg'
                        : cat == 11
                            ? 'postres.jpg'
                            : cat == 5
                                ? 'Pernil.jpg'
                                : 'Pernil.jpg');
        Navigator.pushNamed(context, 'menuselect');
      },
      child: Container(
          height: size.width * 0.45,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu/$foto'), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              this.titulo,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          )),
    );
  }
}
