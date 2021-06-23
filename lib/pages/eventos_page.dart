import 'package:country/services/eventos_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';

class EventosPage extends StatelessWidget {
  final _eventosService = EventosService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Eventos'),
      body: FutureBuilder(
        future: _eventosService.obtenerEventos(),
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.hasData) {
            if (snapshot.data==null) {
              return Center(child: Text('Revise su conexion a Internet'),);
            }
            if (snapshot.data.length == 0) {
              return Center(child: Text('No hay eventos disponibles'),);
            }
          return Column(
            children: [
              Expanded(child: _Eventos(eventos: snapshot.data,)),
              PieLogoWidget()
            ],
          ); 
          }
          return Center(child: CircularProgressIndicator(),);

        },
      )
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
      itemBuilder: (context,index){
        return _Evento(img: eventos[index]['url_jpg'], titulo: eventos[index]['subtitle'], pdf: eventos[index]['url_pdf'],);
      },
    );
  }

}

class _Evento extends StatelessWidget {
  
  final String titulo;
  final String img;
  final String pdf;


  const _Evento({@required this.img ,@required this.titulo, @required this.pdf});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'pdf', arguments: this.pdf);
      },
      child: Container(
          width: double.infinity,
          height: 150.0,
          child: Stack(
                children: [
                  Center(child: FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage(img),fit: BoxFit.cover, width: double.infinity, height: double.infinity,)),
                  // Image(image: NetworkImage(img), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
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
        ),
    );
  }
}