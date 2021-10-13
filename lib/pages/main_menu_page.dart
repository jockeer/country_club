import 'package:carousel_slider/carousel_slider.dart';
import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/providers/notificacion_provider.dart';
import 'package:country/services/comunicado_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:provider/provider.dart';

class MainMenuPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget(
          titulo: '¡Hola ${prefs.nombreSocio}!',
          logoClaro: true,
          color: Colors.transparent,
          main: true,
          centrado: false,
          arrowClaro: true),
      backgroundColor: Colors.black,
      drawerScrimColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: size.height * 0.40,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
              items: [
                Image(
                  image: AssetImage('assets/backgrounds/Instalaciones4.png'),
                  fit: BoxFit.cover,
                  width: size.width,
                ),
                Image(
                  image: AssetImage('assets/backgrounds/Instalaciones1.png'),
                  fit: BoxFit.cover,
                  width: size.width,
                ),
                Image(
                  image: AssetImage('assets/backgrounds/Instalaciones2.png'),
                  fit: BoxFit.cover,
                  width: size.width,
                ),
                Image(
                  image: AssetImage('assets/backgrounds/Instalaciones3.png'),
                  fit: BoxFit.cover,
                  width: size.width,
                ),
              ],
            ),
            _MenuPrincipal()
          ],
        ),
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  final comunicadosService = ComunicadosService();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificacionesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          height: size.height * 0.65,
          width: size.width,
          color: Colors.white,
          child: FutureBuilder(
            future: comunicadosService.obtenerComunicados(context),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OpcionMenu(
                            titulo: 'DISCIPLINAS',
                            icono: 'disciplinas.png',
                            ruta: 'disciplinas'),
                        _OpcionMenu(
                            titulo: 'HORARIOS',
                            icono: 'horarios.png',
                            ruta: 'horarios'),
                        _OpcionMenu(
                            titulo: 'MENSUALIDAD',
                            icono: 'mensualidad.png',
                            ruta: 'mensualidad'),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OpcionMenu(
                            titulo: 'MENÚ RESTAURANT',
                            icono: 'menu.png',
                            ruta: 'menu'),
                        _OpcionMenu(
                            titulo: 'TARJETA CONSUMO',
                            icono: 'tarjeta.png',
                            ruta: 'historico_tarjeta'), // tarjeta
                        _OpcionMenu(
                            titulo: 'RESERVAS',
                            icono: 'reservas.png',
                            ruta: 'reservas'),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OpcionMenu(
                            titulo: 'EVENTOS',
                            icono: 'eventos.png',
                            ruta: 'eventos'),
                        _OpcionMenu(
                            titulo: 'COMUNICADOS',
                            icono: 'comunicados.png',
                            ruta: 'comunicados'),
                        Stack(children: [
                          _OpcionMenu(
                              titulo: 'E-MAILS',
                              icono: 'email.png',
                              ruta: 'inbox'),
                          (provider.mensajesEnEspera == 0)
                              ? Container()
                              : Positioned(
                                  top: 0,
                                  right: size.width * 0.060,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    child: Text(
                                      prefs.mensajesNuevos.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        ]),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OpcionMenu extends StatelessWidget {
  final String titulo, icono, ruta;
  final colores = ColoresApp();
  final prefs = PreferenciasUsuario();
  _OpcionMenu(
      {@required this.titulo, @required this.icono, @required this.ruta});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificacionesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      // height: size.width*0.3,
      child: GestureDetector(
        onTap: () {
          if (this.ruta == 'inbox') {
            prefs.mensajesNuevos = 0;
            provider.mensajesEnEspera = 0;
          }
          Navigator.pushNamed(context, this.ruta);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/icons/$icono'),
              width: size.width * 0.125,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              this.titulo,
              style:
                  TextStyle(fontSize: size.width * 0.033, color: colores.verde),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
