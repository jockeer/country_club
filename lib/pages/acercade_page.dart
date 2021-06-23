import 'package:country/helpers/datos_constantes.dart';
import 'package:country/services/contact_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:country/widgets/pie_logo_widget.dart';

class AcercaDePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Acerca'),
      body: ListView(
        children: [
          _Info(),
          PieLogoWidget()
        ],
      ), 
    );
  }
}

class _Info extends StatelessWidget {
  final _contactService = ContactService();
  final colores= ColoresApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _contactService.obtenerContacto(),
      builder: (context, AsyncSnapshot snapshot ){
        if (snapshot.hasData) {
            if (snapshot.data==null) {
              return Center(child: Text('compruebe su conexion a Internet'),);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('¿Quiénes somos?', style: TextStyle(color: colores.verdeOscuro, fontWeight: FontWeight.bold, fontSize: 20.0),),
                  ),
                  Divider(),
                  Text(snapshot.data["quienesSomos"]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('¿Qué hacemos?', style: TextStyle(color: colores.verdeOscuro, fontWeight: FontWeight.bold, fontSize: 20.0),),
                  ),
                  Divider(),
                  Text(snapshot.data["queHacemos"]),
                ],
              ),
            ); 
          }     
          else{
            return Center(child: CircularProgressIndicator(),);
          }
      },
    );
  }
}