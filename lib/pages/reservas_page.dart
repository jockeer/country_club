import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';


class ReservasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservas', style: TextStyle(color: Colors.black54),),backgroundColor: Colors.transparent, elevation: 0.0,iconTheme: IconThemeData()),
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _MenuReservas(),
            Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
          ],
        ),
      ),
    );
  }
}

class _MenuReservas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _MenuButton(ruta: 'reservas',titulo: 'Deportes', color: Colors.red,),
          _MenuButton(ruta: 'reservas',titulo: 'Cabañas',color: Colors.brown),
          _MenuButton(ruta: 'reservas',titulo: 'Servicios',color: Colors.blue),
          _MenuButton(ruta: 'reservas',titulo: 'Eventos',color: Colors.green),
        ],
      ); 
  }
}

class _MenuButton extends StatelessWidget {

  // final Image imagen;
  final String titulo;
  final String ruta;
  final Color color;

  const _MenuButton({@required this.color ,@required this.titulo, @required this.ruta});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: this.color,
          
        ),
        width: double.infinity,
        height: 150.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 30.0),
              child: Text(this.titulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}