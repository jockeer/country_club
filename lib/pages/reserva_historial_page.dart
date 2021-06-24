
import 'package:country/models/reserva_model.dart';
import 'package:country/services/reserva_service.dart';
import 'package:country/widgets/app_bar_widget.dart';

import 'package:country/widgets/reserva_widget.dart';
import 'package:flutter/material.dart';

class ReservaHistorialPage extends StatelessWidget {

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                  height: MediaQuery.of(context).size.height*0.75,
                  child: _HistorialLista(),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'reservas');
                },
                child: Text('Hacer reserva', style: TextStyle(fontSize: 20.0),),
                style: ElevatedButton.styleFrom(primary: Color(0xff009D47), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
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
      builder: (BuildContext context,AsyncSnapshot<List<Reserva>> snapshot){
     
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(child: Text('No tiene ninguna reserva programada'),);
          } else {
            if (snapshot.data[0] == null) {
              return Center(child: Text('No tiene Conexion a internet'),);
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
