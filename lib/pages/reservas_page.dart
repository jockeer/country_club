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
          _MenuButton(ruta: 'subcatreservas',titulo: 'Deportes', color: Colors.red, subcat: 1,),
          _MenuButton(ruta: 'subcatreservas',titulo: 'Cabañas',color: Colors.brown, subcat: 2,),
          _MenuButton(ruta: 'subcatreservas',titulo: 'Servicios',color: Colors.blue, subcat: 3,),
          _MenuButton(ruta: 'subcatreservas',titulo: 'Eventos',color: Colors.green, subcat: 4,),
        ],
      ); 
  }
}

class _MenuButton extends StatelessWidget {

  // final Image imagen;
  final String titulo;
  final String ruta;
  final Color color;
  final int subcat;

  const _MenuButton({@required this.color ,@required this.titulo, @required this.ruta, @required this.subcat});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, this.ruta, arguments: {"subcat": this.subcat, "titulo": this.titulo});
      },
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