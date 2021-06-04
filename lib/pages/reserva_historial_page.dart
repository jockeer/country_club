
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';

class ReservaHistorialPage extends StatelessWidget {

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Reservas'),
      drawer: MenuLateralWidget(),
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


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Reserva(id: "1", titulo: "Cabaña la Palmera", estado: "Reservada", capacidad: "40", fecha: "Miercoles, 31 de Marzo", hora: "15:30",),
        _Reserva(id: "2", titulo: "Cancha de Tenis", estado: "Finalizado", capacidad: "6", fecha: "Miercoles, 11 de Febrero", hora: "16:00",),
        _Reserva(id: "3", titulo: "Cabaña Hoyo-19", estado: "En proceso", capacidad: "20", fecha: "Martes, 20 de Abril", hora: "12:00",),
        _Reserva(id: "1", titulo: "Cabaña la Palmera", estado: "Reservada", capacidad: "40", fecha: "Miercoles, 31 de Marzo", hora: "15:30",),
  
      ],
    );
  }
}

class _Reserva extends StatelessWidget {

  final String id;
  final String titulo;
  final String estado;
  final String capacidad;
  final String fecha;
  final String hora;

  const _Reserva({ @required this.id, @required this.titulo, @required this.estado, @required this.capacidad, @required this.fecha, @required this.hora});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            blurRadius: 4.0,
            offset: Offset(0.0, 5.0), // changes position of shadow
          ),
        ]
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(Icons.redeem),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.titulo, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Text(
                          this.estado, 
                          style: TextStyle(
                            fontSize: 14.0 ,
                            color: (this.estado == "Reservada") ? Colors.green : (this.estado=="En proceso")?Colors.orange: Colors.black54, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Text('Capacidad: ${this.capacidad} personas'),
                        SizedBox(height: 5.0,),
                        Text('${this.fecha}, ${this.hora}'),
                        SizedBox(height: 10.0,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                // Expanded(child: Container(),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: (this.estado == "Reservada" || this.estado == "En proceso")
                  ? ([
                      ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Reprogramar'),),
                      SizedBox(width: 20.0,),
                      ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))) ,child: Text('Cancelar Reserva'),),
                    ])
                  : [
                      ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Visualizar Reserva'),),
                    ]    
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}