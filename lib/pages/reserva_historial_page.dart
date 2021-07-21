import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/services/reserva_service.dart';
import 'package:country/widgets/app_bar_widget.dart';

import 'package:country/widgets/reserva_widget.dart';
import 'package:flutter/material.dart';

class ReservaHistorialPage extends StatelessWidget {
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Reservas'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // SizedBox(height: 65.0,),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: _HistorialLista(),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'reservas');
                },
                child: estilos.buttonChild(texto: 'Hacer reserva'),
                style: estilos.buttonStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HistorialLista extends StatelessWidget {
  final reservasSevice = ReservaService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: reservasSevice.obtenerReservas(),
      builder: (BuildContext context, AsyncSnapshot<List<Reserva>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text('No tiene ninguna reserva programada'),
            );
          } else {
            if (snapshot.data[0] == null) {
              return Center(
                child: Text('No tiene Conexión a internet'),
              );
            } else {
              return ReservaWidget(reservas: snapshot.data);
            }
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
