import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';

class EventosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Eventos'),
      body: ListView(
        children: [
          _Evento(titulo: 'La palmera', img: 'La_palmera.png', subcat: 1,galeria: 'palmeras',),
          _Evento(titulo: 'La palmera', img: 'El_Caribeño.png', subcat: 1,galeria: 'palmeras',),
          _Evento(titulo: 'La palmera', img: 'Hoyo_19.png', subcat: 1,galeria: 'palmeras',),
          PieLogoWidget(),
        ],
      ),
    );
  }
}

class _Evento extends StatelessWidget {

  // final Image imagen;
  final String titulo;
  final String img;
  final String galeria;
  final int subcat;

  const _Evento({@required this.img ,@required this.titulo, @required this.subcat, this.galeria});


  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150.0,
        child: Stack(
              children: [
                Image(image: AssetImage('assets/images/${this.img}'), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
                Column(
                  children: [
                    Expanded(child: Container(),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      color: Colors.black38,
                      width: double.infinity, 
                      child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900, fontSize: 16.0),)
                    )
                  ],
                )
              ],
            ),
      );
  }
}