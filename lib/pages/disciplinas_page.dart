import 'package:carousel_slider/carousel_slider.dart';
import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/providers/disciplina_provider.dart';
import 'package:country/services/disciplinas_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisciplinasPage extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBarWidget(
          titulo: '¡Hola ${prefs.nombreSocio}!',
          logoClaro: true,
          color: Colors.transparent,
          main: true,
          centrado: false,
          arrowClaro: true),
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
  final disciplinasService = DisciplinasService();
  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DisciplinaProvider>(context);
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
              future: disciplinasService.obtenerDisciplinas(),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 60),
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 0,
                            left: 50,
                            right: 50,
                            top: (index == 0) ? 0 : 0),
                        child: Column(
                          children: [
                            (snapshot.data[index]["desplegable"] != "0")
                                ? FutureBuilder(
                                    future: disciplinasService
                                        .obtenerSubDisciplinas(4),
                                    builder: (_, AsyncSnapshot snapshota) {
                                      if (snapshota.hasData) {
                                        final List submenu = snapshota.data;
                                        return Theme(
                                          data: ThemeData().copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            collapsedIconColor: colores.verde,
                                            iconColor: colores.verde,
                                            leading: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${snapshot.data[index]["logo"]}'),
                                                width: 40,
                                              ),
                                            ),
                                            title: GestureDetector(
                                                onTap: () {
                                                  provider.banerTop = 0;
                                                  provider.menuAlto = false;
                                                  if (snapshot.data[index]
                                                          ["torneo"] ==
                                                      "1") {
                                                    Navigator.pushNamed(
                                                        context, 'disciplina',
                                                        arguments: snapshot
                                                            .data[index]);
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context, 'fronton',
                                                        arguments: snapshot
                                                            .data[index]);
                                                  }
                                                },
                                                child: Text(
                                                  snapshot.data[index]
                                                      ["nombreDisciplina"],
                                                  style: TextStyle(
                                                      color:
                                                          colores.verdeOscuro,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )),
                                            children: submenu.map((e) {
                                              return GestureDetector(
                                                onTap: () {
                                                  provider.banerTop = 0;
                                                  provider.menuAlto = false;
                                                  if (snapshot.data[index]
                                                          ["torneo"] ==
                                                      "1") {
                                                    Navigator.pushNamed(
                                                        context, 'disciplina',
                                                        arguments: e);
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context, 'fronton',
                                                        arguments: e);
                                                  }
                                                },
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Text(
                                                      e["nombreDisciplina"],
                                                      style: TextStyle(
                                                          color: colores
                                                              .verdeOscuro),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  )
                                : ListTile(
                                    dense: true,
                                    leading: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Image(
                                        image: NetworkImage(
                                            'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${snapshot.data[index]["logo"]}'),
                                        width: 40,
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data[index]["nombreDisciplina"],
                                      style: TextStyle(
                                          color: colores.verdeOscuro,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    onTap: () {
                                      provider.banerTop = 0;
                                      provider.menuAlto = false;
                                      if (snapshot.data[index]["torneo"] ==
                                          "1") {
                                        Navigator.pushNamed(
                                            context, 'disciplina',
                                            arguments: snapshot.data[index]);
                                      } else {
                                        Navigator.pushNamed(context, 'fronton',
                                            arguments: snapshot.data[index]);
                                      }
                                    },
                                  ),
                            Divider(
                              thickness: 1,
                              color: colores.verdeOscuro,
                              height: 25,
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ),
    );
  }
}
