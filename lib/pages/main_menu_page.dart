import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/mensaje_model.dart';
import 'package:country/services/comunicado_service.dart';
import 'package:country/services/inbox_servide.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainMenuPage extends StatelessWidget {
  final prefs = PreferenciasUsuario();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (prefs.notificacionEnCola.length==0) {
      print('vacio');
      print(prefs.notificacionEnCola.length);
    } else {
      cargarNotificacion();
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _Menu(),
              PieLogoWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.menu, color: Colors.white,),
        onPressed: (){
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );  
  }

  cargarNotificacion()async{
    final mensaje = MensajeInbox();
    mensaje.idNotificacion = prefs.notificacionEnCola[0];
    mensaje.titulo = prefs.notificacionEnCola[1];
    mensaje.mensaje = prefs.notificacionEnCola[2];
    mensaje.fecha = prefs.notificacionEnCola[3];
    await DBInboxService.db.nuevoMensaje(mensaje);
  }
}


class _Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;

    return Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'tarjeta'),
            child: Container(
              width: phoneSize.width,
              height: phoneSize.height*0.32,
              child: Stack(
                children: [
                  Image(image: AssetImage('assets/images/Tarjeta.png'), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        color: Colors.black38,
                        width: double.infinity, 
                        alignment: Alignment.centerRight,
                        child: Text('Tarjeta de Consumo', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                      )
                    ],
                  )
                  
                ],
              )
            ),
          ),
          SizedBox(height: 20.0,),
          _Comunicados(),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Histórico de tarjeta", img: 'Historial_tarjeta', ruta: 'historico_tarjeta', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Mensualidad", img: 'Mensualidad', ruta: 'mensualidad', lado: "der"),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Menú", img: 'Menu', ruta: 'menu', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Inbox", img: 'Inbox', ruta: 'inbox', lado: "der"),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Reservas", img: 'Reservas', ruta: 'reservas', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Historial de resersas", img: 'Historial_de_reserva', ruta: 'reservas_historial', lado: "der"),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Eventos", img: 'Eventos', ruta: 'eventos', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Hándicap", img: 'Handicap', ruta: 'handicap', lado: "der"),
            ],
          ),
          SizedBox(height: 20.0,),
          

        ],
      );
  }
}

class _ButtonMenu extends StatelessWidget {

  final String titulo;
  final String img;
  final String ruta;
  final String lado;

  _ButtonMenu({@required this.titulo, @required this.img, @required this.ruta, @required this.lado});

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, this.ruta);
        },
        child: ClipRRect(
          borderRadius: (this.lado=='izq' 
            ? BorderRadius.only(topRight: Radius.circular(20.0),bottomRight:Radius.circular(20.0))
            : BorderRadius.only(topLeft: Radius.circular(20.0),bottomLeft:Radius.circular(20.0))
          ),
          child: Container(
            height: phoneSize.height*0.15,
            child: Stack(
              children: [
                Image(image: AssetImage('assets/images/${this.img}.png'), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      color: Colors.black38,
                      width: double.infinity, 
                      alignment: Alignment.centerRight,
                      child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Comunicados extends StatelessWidget {
  final comunicadoService = ComunicadosService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  comunicadoService.obtenerComunicados(),
      builder: ( _, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) {
          return CarouselSlider.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index, realIndex) => _Comunicado(comunicado: snapshot.data[index],),
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 3),
              // enableInfiniteScroll: false,
              viewportFraction: 0.85,
              autoPlay: true,
              aspectRatio: 3.0,
              enlargeCenterPage: true
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ); 
  }
}

class _Comunicado extends StatelessWidget {
  final dynamic comunicado;

  _Comunicado({@required this.comunicado});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image(image: NetworkImage(this.comunicado["img"]),fit: BoxFit.cover, width: size.width,),
        Positioned(child: Container( width: size.width, color: Colors.black54,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(this.comunicado["title"], style: TextStyle(fontSize: size.width*0.035,color: Colors.white,fontWeight: FontWeight.bold )),
        )),),

      ],
        
    );
  }
}