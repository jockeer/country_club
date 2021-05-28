import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';

class MainMenuPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _Menu(),
              Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
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
                        child: Text('Tarjeta de Consumo', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),)
                      )
                    ],
                  )
                  
                ],
              )
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Historico de tarjeta", img: 'Historial_tarjeta', ruta: 'historico_tarjeta', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Mensualidad", img: 'Mensualidad', ruta: 'menu', lado: "der"),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              _ButtonMenu(titulo: "Menu", img: 'Menu', ruta: 'menu', lado: "izq",),
              SizedBox(width: 15.0,),
              _ButtonMenu(titulo: "Inbox", img: 'Inbox', ruta: 'menu', lado: "der"),
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
              _ButtonMenu(titulo: "Handicap", img: 'Handicap', ruta: 'menu', lado: "der"),
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
                      child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),)
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