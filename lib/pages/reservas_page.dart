import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/cabana_model.dart';
import 'package:country/providers/galeria_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/cabana_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservasPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
          titulo: 'Reservas', texto: colores.verdeClaro, logoClaro: true),
      body: Container(
          width: size.width,
          height: size.height,
          child: Stack(children: [
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
                    height: size.height * 0.86,
                    child: _MenuReservas()),
              ),
            )
          ])),
    );
  }
}

class _MenuReservas extends StatelessWidget {
  final _cabanaService = CabanaService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cabanaService.obtenerCabanas(),
      builder: (_, AsyncSnapshot<List<Cabana>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              _Cabanas(
                cabanas: snapshot.data,
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Cabanas extends StatelessWidget {
  final List<Cabana> cabanas;

  _Cabanas({@required this.cabanas});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cabanas.length,
        itemBuilder: (_, index) {
          return _OptCabana(
            titulo: cabanas[index].nombreCabana,
            foto: cabanas[index].foto,
            idcab: cabanas[index].id,
            galeria: 'palmeras',
            cabanas: this.cabanas,
            cantidad: cabanas[index].cantidad,
            dimension: cabanas[index].dimension,
          );
        },
      ),
    );
  }
}

class _OptCabana extends StatelessWidget {
  final String titulo;
  final String foto;
  final String galeria;
  final String idcab;
  final String cantidad;
  final String dimension;
  final List<Cabana> cabanas;

  const _OptCabana(
      {@required this.foto,
      @required this.titulo,
      @required this.idcab,
      this.galeria,
      this.cabanas,
      @required this.cantidad,
      @required this.dimension});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    final providerGaleria = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.codigoCab = this.idcab;
        provider.maxPersonas = this.cantidad;
        Navigator.pushNamed(context, 'reserva_proceso',
            arguments: this.cabanas);
      },
      child: Container(
        width: double.infinity,
        height: 150.0,
        child: Stack(
          children: [
            Image(
              image: NetworkImage(
                  'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/cabanas/$foto'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    color: Colors.black38,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          this.titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        GestureDetector(
                            onTap: () {
                              provider.detalles = int.parse(this.idcab);
                              print(provider.detalles);
                            },
                            child: Text(
                              '+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0),
                            ))
                      ],
                    ))
              ],
            ),
            (provider.detalles == int.parse(this.idcab)
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.9,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.titulo.toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('CAPACIDAD: $cantidad PERSONAS'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('DIMENSION: $dimension')
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()),
            (provider.detalles == int.parse(this.idcab)
                ? Positioned(
                    bottom: 0,
                    right: 15,
                    child: GestureDetector(
                        onTap: () {
                          provider.detalles = 0;
                        },
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 60.0),
                        )))
                : Container()),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  providerGaleria.galeria = this.galeria;
                  Navigator.pushNamed(context, 'galeria',
                      arguments: this.idcab);
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage('assets/icons/foto.png'),
                    width: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
