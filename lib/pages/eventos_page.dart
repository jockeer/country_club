import 'package:country/providers/galeria_provider.dart';
import 'package:country/services/eventos_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventosPage extends StatelessWidget {
  final _eventosService = EventosService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Eventos', color: Color(0xffD9D1CA), texto: Colors.green),
      body: SafeArea(
        child: FutureBuilder(
          future: _eventosService.obtenerEventos(),
          builder: (context, AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              if (snapshot.data==null) {
                return Center(child: Text('Revise su conexion a Internet'),);
              }
              if (snapshot.data.length == 0) {
                return Center(child: Text('No hay eventos disponibles'),);
              }
              return Container(
                width: size.width,
                height: size.height,
                color: Color(0xffD9D1CA),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        child: Container(
                          width: size.width,
                          height: size.height*0.85,
                          color: Colors.white,
                          child: _Eventos(eventos: snapshot.data,),
                        ),
                      ),
                    )
                  ],
                ),
              );
            // return Column(
            //   children: [
            //     Expanded(child: _Eventos(eventos: snapshot.data,)),
            //   ],
            // ); 
            }
            return Center(child: CircularProgressIndicator(),);
      
          },
        ),
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
        return _Evento(evento: eventos[index],);
      },
    );
  }

}

class _Evento extends StatelessWidget {
  
  final evento;

  const _Evento({@required this.evento});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
      onTap: (){
        provider.tituloExtra=1;
        Navigator.pushNamed(context, 'pdf', arguments: this.evento["url_pdf"]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: size.width*0.42,
                height: size.width*0.3,
                child: FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage(this.evento["url_jpg"]), fit: BoxFit.cover,),
              ),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(this.evento["subtitle"], style: TextStyle( fontWeight: FontWeight.bold ),),
                SizedBox(height: 5,),
                Text('${this.evento["desde"]}', style: TextStyle( fontSize: 12, color: Colors.grey ),),
                SizedBox(height: 5,),
                Text('hasta ${this.evento["until"]}', style: TextStyle( fontSize: 12, color: Colors.grey ),),
              ],
            )
          ],
        ),
      )
      // child: Container(
      //   width: double.infinity,
      //   height: 150.0,
      //   child: Stack(
      //         children: [
      //           Center(child: FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage(img),fit: BoxFit.cover, width: double.infinity, height: double.infinity,)),
      //           // Image(image: NetworkImage(img), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
      //           Column(
      //             children: [
      //               Expanded(child: Container(),),
      //               Container(
      //                 padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      //                 color: Colors.black38,
      //                 width: double.infinity, 
      //                 child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16.0),)
      //               )
      //             ],
      //           )
      //         ],
      //   ),
      // ),
    );
  }
}