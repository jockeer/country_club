import 'package:country/helpers/datos_constantes.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/menu_lateral_widget.dart';

class MensualidadPage extends StatelessWidget {

  final colores =ColoresApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: "Mensualidad"),
      drawer: MenuLateralWidget(),
      body: Column(
        children: [
          Container(width: double.infinity,color: colores.gris,child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            child: Text("Pagos realizados", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),),
          ExpansionTile(
            title: Text('prueba desplegable'),
            children: [
              ListTile(
                title: Text('Titulo 1'),
                subtitle: Text('Subtitulo 1'),
              ),
              ListTile(
                title: Text('Titulo 2'),
                subtitle: Text('Subtitulo 2'),
              ),
              ListTile(
                title: Text('Titulo 3'),
                subtitle: Text('Subtitulo 3'),
              ),
            ],
          ),
          Container(width: double.infinity,color: colores.verdeOscuro,child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            child: Text("Pagos recientes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),),
          Container(width: double.infinity,color: colores.naranjaClaro,child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            child: Text("Pagos pendientes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),),
          


        ],
      ),
    );
  }
}