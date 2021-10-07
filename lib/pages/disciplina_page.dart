import 'dart:io';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/providers/disciplina_provider.dart';
import 'package:country/providers/eventos_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/disciplinas_service.dart';
import 'package:country/services/eventos_service.dart';
import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisciplinaPage extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final dynamic disciplina = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DisciplinaProvider>(context);
    return Scaffold(
        backgroundColor:
            (provider.menuAlto) ? colores.verdeClaro : Colors.white,
        extendBodyBehindAppBar: true,
        appBar: appBarWidget(
          titulo: disciplina["nombreDisciplina"],
          color: (provider.menuAlto) ? colores.verdeClaro : Colors.transparent,
          texto: Colors.white,
          arrowClaro: true,
          logoClaro: (provider.menuAlto) ? false : true,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              (provider.menuAlto)
                  ? Container()
                  // : Image(image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${disciplina["foto"]}')),
                  : Container(
                      width: size.width,
                      height: size.height * 0.40,
                      child: Image(
                        image: NetworkImage(
                            'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${(provider.banerTop == 0) ? disciplina["foto"] : (provider.banerTop == 1) ? disciplina["banerprofe"] : disciplina["banertorneo"]}'),
                        fit: BoxFit.cover,
                      )),
              _MenuPrincipal(disciplina: disciplina, provider: provider)
            ],
          ),
        ));
  }
}

class _MenuPrincipal extends StatefulWidget {
  final dynamic disciplina;
  final DisciplinaProvider provider;

  _MenuPrincipal({@required this.disciplina, @required this.provider});

  @override
  State<_MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<_MenuPrincipal>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    if (this.widget.disciplina["handicap"] == null ||
        this.widget.disciplina["handicap"] == "") {
      _tabController = TabController(vsync: this, length: 4, initialIndex: 0);
    } else {
      _tabController = TabController(vsync: this, length: 5, initialIndex: 0);
    }

    super.initState();

    _tabController.addListener(() {
      cambio();
    });
  }

  void cambio() {
    print(_tabController.index);
    this.widget.provider.banerTop = _tabController.index;
    if (_tabController.index == 3 || _tabController.index == 4) {
      this.widget.provider.menuAlto = true;
    } else {
      this.widget.provider.menuAlto = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            padding: EdgeInsets.only(top: 20),
            height:
                (provider.menuAlto) ? size.height * 0.85 : size.height * 0.65,
            width: size.width,
            color: Colors.white,
            child: DefaultTabController(
              length: (widget.disciplina["handicap"] == null ||
                      widget.disciplina["handicap"] == "")
                  ? 4
                  : 5,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    onTap: (value) {
                      provider.banerTop = value;
                      if (value == 3 || value == 4) {
                        provider.menuAlto = true;
                      } else {
                        provider.menuAlto = false;
                      }
                    },
                    isScrollable: true,
                    indicatorColor: Colors.green,
                    indicatorWeight: 2.0,
                    labelColor: Colors.black,
                    tabs: (widget.disciplina["handicap"] == null ||
                            widget.disciplina["handicap"] == "")
                        ? [
                            Tab(
                              child: Text(
                                'Horarios',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Profesores',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Torneos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reglamento',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            )
                          ]
                        : [
                            Tab(
                              child: Text(
                                'Horarios',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Profesores',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Torneos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Handicap',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reglamento',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.034),
                              ),
                            )
                          ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: (widget.disciplina["handicap"] == null ||
                              widget.disciplina["handicap"] == "")
                          ? [
                              _Horarios(
                                horario: widget.disciplina['horario'],
                              ),
                              _Profesores(
                                disciplina: this.widget.disciplina,
                              ),
                              _Calendario(
                                idDisciplina:
                                    int.parse(widget.disciplina['id']),
                              ),
                              _Reglamento(
                                  reglamento: widget.disciplina['reglamento'])
                            ]
                          : [
                              _Horarios(
                                horario: widget.disciplina['horario'],
                              ),
                              _Profesores(
                                disciplina: this.widget.disciplina,
                              ),
                              _Calendario(
                                  idDisciplina:
                                      int.parse(widget.disciplina['id'])),
                              Handicap(),
                              _Reglamento(
                                reglamento: widget.disciplina['reglamento'],
                              )
                            ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class _Profesores extends StatelessWidget {
  final estilos = EstilosApp();
  final disciplinasService = DisciplinasService();
  final dynamic disciplina;

  _Profesores({@required this.disciplina});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: disciplinasService.obetenerProfesores(this.disciplina["id"]),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Container(
                              height: 120,
                              width: 120,
                              child: (snapshot.data[index]["foto"] == "" ||
                                      snapshot.data[index]["foto"] == null)
                                  ? Container(
                                      color: Colors.grey,
                                      height: 120,
                                      width: 120,
                                    )
                                  : Image(
                                      image: NetworkImage(
                                          'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/profesores/${snapshot.data[index]["foto"]}'),
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${snapshot.data[index]["nombre"]} ${snapshot.data[index]["apellido"]}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${snapshot.data[index]["descripcion"]}',
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  abrirWhatassp(
                                      snapshot.data[index]["telefono"]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: ColoresApp().naranjaClaro,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    snapshot.data[index]["telefono"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Divider()
                ],
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void abrirWhatassp(String telefono) async {
    final whatsaapANDROID = "whatsapp://send?phone=591$telefono";
    final whatsaapIOS = "https://wa.me/591$telefono";
    if (Platform.isIOS) {
      await canLaunch(whatsaapIOS)
          ? await launch(whatsaapIOS, forceSafariVC: false)
          : print("instale whatsaap");
    } else {
      await canLaunch(whatsaapANDROID)
          ? await launch(whatsaapANDROID)
          : print('instale Whastaap');
    }
  }
}

class Handicap extends StatefulWidget {
  @override
  _HandicapState createState() => _HandicapState();
}

class _HandicapState extends State<Handicap> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://fbg.bo.plus.golf/handicap/",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class _Reglamento extends StatelessWidget {
  final _pdfService = PdfService();
  final String reglamento;
  _Reglamento({@required this.reglamento});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF(
          'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/reglamentos/$reglamento'),
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          if (snapshot.data == 'error') {
            return Center(
              child: Text(
                'Error al cargar archivo!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            child: PDFView(
              pageFling: false,
              pageSnap: false,
              filePath: snapshot.data.path,
              swipeHorizontal: false,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Horarios extends StatelessWidget {
  final _pdfService = PdfService();
  final String horario;
  _Horarios({@required this.horario});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF(
          'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/horarios/$horario'),
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          if (snapshot.data == 'error') {
            return Center(
              child: Text(
                'Error al cargar archivo!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            child: PDFView(
              pageFling: false,
              pageSnap: false,
              filePath: snapshot.data.path,
              swipeHorizontal: false,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Calendario extends StatelessWidget {
  final eventosService = EventosService();
  final int idDisciplina;
  _Calendario({@required this.idDisciplina});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventosProvider>(context);
    return FutureBuilder(
        future:
            eventosService.obtenerTorneosCalendario(context, this.idDisciplina),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            EventList<Event> _markedDateMap =
                new EventList<Event>(events: snapshot.data.events);
            return SingleChildScrollView(
              child: Column(
                children: [
                  _Calendar(
                    markedDateMap: _markedDateMap,
                  ),
                  Container(
                    child: (provider.fechaElegida == "" ||
                            provider.fechaElegida == null)
                        ? Container()
                        : FutureBuilder(
                            future: eventosService.obtenerTorneosPorFecha(
                                provider.fechaElegida, this.idDisciplina),
                            builder: (_, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Center(
                                    child: Text('Sin Torneos'),
                                  );
                                }
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 0, bottom: 0),
                                        child: ListTile(
                                          dense: false,
                                          title: Text(
                                            snapshot.data[index]["title"],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            '${snapshot.data[index]["inicio"]} al ${snapshot.data[index]["fin"]}',
                                            style: TextStyle(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class _Calendar extends StatefulWidget {
  final EventList<Event> markedDateMap;
  _Calendar({@required this.markedDateMap});
  @override
  __CalendarState createState() => __CalendarState();
}

class __CalendarState extends State<_Calendar> {
  final colores = ColoresApp();
  DateTime _currentDate;
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    final providerEvento = Provider.of<EventosProvider>(context);
    // DateTime fecha = DateTime(today.year, today.month, today.day);
    return Container(
      height: 380,
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 0.0),
      child: CalendarCarousel(
        customGridViewPhysics: ScrollPhysics(),
        staticSixWeekFormat: true,
        markedDatesMap: this.widget.markedDateMap,
        selectedDayBorderColor: colores.verdeMenuLateral,
        selectedDayButtonColor: colores.verdeMenuLateral,
        todayButtonColor: Colors.transparent,
        todayBorderColor: colores.verdeClaro,
        todayTextStyle: TextStyle(color: Colors.black),
        locale: 'es',
        onDayPressed: (DateTime date, List events) {
          // print(DateTime(date.year,date.month,date.day));
          provider.fechaEvento =
              DateTime(date.year, date.month, date.day).toString();
          // print(provider.fechaEvento);
          final fechaprueba = DateFormat('yyyy-MM-dd').format(date);
          providerEvento.fechaElegida = fechaprueba;
          // providerEvento.fechaElegida =
          setState(() {
            _currentDate = DateTime(date.year, date.month, date.day);
          });
        },
        iconColor: Colors.black,
        headerTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        headerTitleTouchable: true,
        weekendTextStyle: TextStyle(
          color: Colors.green,
        ),
        thisMonthDayBorderColor: Colors.transparent,
        // minSelectedDate: fecha,

        // weekFormat: false,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,
      ),
    );
  }
}
