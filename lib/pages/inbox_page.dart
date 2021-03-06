import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/disciplina_provider.dart';
import 'package:country/services/inbox_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  final estilos = EstilosApp();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DisciplinaProvider>(context);
    return Scaffold(
      appBar: appBarWidget(
          titulo: 'INBOX',
          color: (provider.generalup) ? colores.verde : colores.verdeClaro,
          texto: Colors.white,
          arrowClaro: true,
          logoClaro: (provider.generalup) ? true : false),
      backgroundColor:
          (provider.generalup) ? colores.verde : colores.verdeClaro,
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
                    color: Colors.white,
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TabBar(
                            onTap: (value) {
                              provider.generalup = false;
                              provider.personalup = false;
                              provider.todosup = false;
                            },
                            indicatorColor: colores.verde,
                            indicatorWeight: 4.0,
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Personales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.033),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Generales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.033),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Todos',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.033),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [_Personales(), _Generales(), _Todos()],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Todos extends StatelessWidget {
  final inboxService = InboxService();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DisciplinaProvider>(context);
    return Stack(
      children: [
        FutureBuilder(
          future: inboxService.obtenerAllMensajes(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No tiene mensajes'),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.mail_outline_outlined,
                      size: 50,
                      color: (snapshot.data[index]["general"] == "1")
                          ? colores.verde
                          : colores.naranja,
                    ),
                    title: Text(
                      snapshot.data[index]["titulo"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6C625A)),
                    ),
                    subtitle: Text(
                      snapshot.data[index]["fecha"],
                      style: TextStyle(color: Color(0xff574e45)),
                    ),
                    onTap: () {
                      provider.todosup = true;
                      provider.mensajeALL = snapshot.data[index];
                      print(provider.mensajeALL);
                    },
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        (provider.todosup)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            provider.mensajeALL["titulo"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6C625A)),
                          ),
                          subtitle: Text(
                            provider.mensajeALL["fecha"],
                            style: TextStyle(color: Color(0xff574e45)),
                          ),
                        ),
                        (provider.mensajeALL["img"] == null ||
                                provider.mensajeALL["img"] == "")
                            ? Container()
                            : Image(
                                image: NetworkImage(
                                    'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/inbox/${provider.mensajeALL["img"]}')),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            child: Text(provider.mensajeALL["mensaje"]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        (provider.mensajeALL["emisor"] == null ||
                                provider.mensajeALL["emisor"] == "")
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.mensajeALL["emisor"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      provider.mensajeALL["desc"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            provider.todosup = false;
                          },
                        )),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}

class _Generales extends StatelessWidget {
  final inboxService = InboxService();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DisciplinaProvider>(context);
    return Stack(
      children: [
        FutureBuilder(
          future: inboxService.obtenerMensajesGenerales(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No tiene mensajes Generales'),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    dense: true,
                    leading: Icon(Icons.mail_outline_outlined,
                        size: 50, color: colores.verde),
                    title: Text(
                      snapshot.data[index]["titulo"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6C625A)),
                    ),
                    subtitle: Text(
                      snapshot.data[index]["fecha"],
                      style: TextStyle(color: Color(0xff574e45)),
                    ),
                    onTap: () {
                      provider.generalup = true;
                      provider.mensajeGeneral = snapshot.data[index];
                      print(provider.mensajeGeneral);
                    },
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        (provider.generalup)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            provider.mensajeGeneral["titulo"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6C625A)),
                          ),
                          subtitle: Text(provider.mensajeGeneral["fecha"],
                              style: TextStyle(color: Color(0xff574e45))),
                        ),
                        (provider.mensajeGeneral["img"] == null ||
                                provider.mensajeGeneral["img"] == "")
                            ? Container()
                            : Image(
                                image: NetworkImage(
                                    'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/inbox/${provider.mensajeGeneral["img"]}')),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            child: Text(provider.mensajeGeneral["mensaje"]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        (provider.mensajeGeneral["emisor"] == null ||
                                provider.mensajeGeneral["emisor"] == "")
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.mensajeGeneral["emisor"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      provider.mensajeGeneral["desc"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            provider.generalup = false;
                          },
                        )),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}

class _Personales extends StatelessWidget {
  final inboxService = InboxService();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DisciplinaProvider>(context);
    return Stack(
      children: [
        FutureBuilder(
          future: inboxService.obtenerMensajesPersonales(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No tiene mensajes personales'),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.mail_outline_outlined,
                      size: 50,
                      color: colores.naranja,
                    ),
                    title: Text(
                      snapshot.data[index]["titulo"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6C625A)),
                    ),
                    subtitle: Text(
                      snapshot.data[index]["fecha"],
                      style: TextStyle(color: Color(0xff574e45)),
                    ),
                    onTap: () {
                      provider.personalup = true;
                      provider.mensajePersonal = snapshot.data[index];
                      print(provider.mensajePersonal);
                    },
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        (provider.personalup)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            provider.mensajePersonal["titulo"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6C625A)),
                          ),
                          subtitle: Text(
                            provider.mensajePersonal["fecha"],
                            style: TextStyle(color: Color(0xff574e45)),
                          ),
                        ),
                        (provider.mensajePersonal["img"] == null ||
                                provider.mensajePersonal["img"] == "")
                            ? Container()
                            : Image(
                                image: NetworkImage(
                                    'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/inbox/${provider.mensajePersonal["img"]}')),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            child: Text(provider.mensajePersonal["mensaje"]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        (provider.mensajePersonal["emisor"] == null ||
                                provider.mensajePersonal["emisor"] == "")
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.mensajePersonal["emisor"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      provider.mensajePersonal["desc"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            provider.personalup = false;
                          },
                        )),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
