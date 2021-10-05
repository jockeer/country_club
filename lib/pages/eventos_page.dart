import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/eventos_provider.dart';
import 'package:country/providers/galeria_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/eventos_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventosPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colores.gris,
        appBar: appBarWidget(
            titulo: 'EVENTOS',
            color: colores.gris,
            texto: Colors.green,
            logoClaro: true),
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
                        length: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TabBar(
                              isScrollable: false,
                              indicatorColor: colores.verdeClaro,
                              indicatorWeight: 3.0,
                              labelColor: Colors.black,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Eventos',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Calendario',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [_ListaEventos(), _Calendario()],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}

class _ListaEventos extends StatelessWidget {
  final _eventosService = EventosService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _eventosService.obtenerEventos(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Center(
              child: Text('Revise su conexion a Internet'),
            );
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No hay eventos disponibles'),
            );
          }
          return _Eventos(
            eventos: snapshot.data,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Eventos extends StatelessWidget {
  final List eventos;

  _Eventos({@required this.eventos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return _Evento(
          evento: eventos[index],
        );
      },
    );
  }
}

class _Evento extends StatelessWidget {
  final evento;

  const _Evento({@required this.evento});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
        onTap: () {
          provider.tituloExtra = 1;
          Navigator.pushNamed(context, 'pdf',
              arguments: this.evento["url_pdf"]);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: size.width * 0.42,
                  height: size.width * 0.3,
                  child: Image(
                    image: NetworkImage(this.evento["url_jpg"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    this.evento["subtitle"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${this.evento["desde"]}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'hasta ${this.evento["until"]}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class _Calendario extends StatelessWidget {
  final eventosService = EventosService();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventosProvider>(context);
    return FutureBuilder(
        future: eventosService.obtenerEventosCalendario(context),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            EventList<Event> _markedDateMap =
                new EventList<Event>(events: snapshot.data.events);
            return Column(
              children: [
                _Calendar(
                  markedDateMap: _markedDateMap,
                ),
                Expanded(
                  child: Container(
                    child: (provider.fechaElegida == "" ||
                            provider.fechaElegida == null)
                        ? Container()
                        : FutureBuilder(
                            future: eventosService
                                .obtenerEventosPorFecha(provider.fechaElegida),
                            builder: (_, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Center(
                                    child: Text('Sin Eventos'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: ListTile(
                                        dense: false,
                                        title: Text(
                                          snapshot.data[index]["subtitle"],
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
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                  ),
                )
              ],
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
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: CalendarCarousel(
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
