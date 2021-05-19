import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';

class MenuPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu', style: TextStyle(color: Colors.black38),),backgroundColor: Colors.transparent, iconTheme: IconThemeData(), elevation: 0.0,),
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Menu(),
            Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
          ],
        ),
      )
    );  
  }
}


class _Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // final phoneSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'tarjeta');
            },
            child: Card(
              color: Color(0xff009D47),
              elevation: 10.0,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
              child: Container(         
                height: 100.0,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container( 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight:Radius.circular(10.0) ),
                            color: Colors.black38,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('Tarjeta de consumo', textAlign: TextAlign.right, style: TextStyle(color: Colors.white),),
                          )
                        ),
                      ],
                    ),                
                  ],
                ),
              )
            ),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Historico de tarjeta', color: Colors.yellow, ruta: 'reservas'),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Mensualidad', color: Colors.green, ruta: 'reservas')
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Menu', color: Colors.yellow, ruta: 'reservas'),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Inbox', color: Colors.green, ruta: 'reservas')
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Reservas', color: Colors.yellow, ruta: 'reservas'),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Historial de reservas', color: Colors.green, ruta: 'reservas')
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Eventos', color: Colors.yellow, ruta: 'reservas',),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Handicap', color: Colors.green, ruta: 'reservas')
            ],
          ),
        ],
      ),
    );
  }
}

class _ButtonMenu extends StatelessWidget {

  final String titulo;
  final Color color;
  final String ruta;

  _ButtonMenu({@required this.titulo, @required this.color, @required this.ruta});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'reservas');
        },
        child: Card(
          color: Color(0xff009D47),
          elevation: 10.0,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          child: Container(         
            height: 100.0,
            child: Stack(
              children: [
                // _FondoPantalla(),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container( 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight:Radius.circular(20.0) ),
                          color: Colors.black38,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: Text(this.titulo, textAlign: TextAlign.right, style: TextStyle(color: Colors.white),),
                        )
                      ),
                    ],
                  ),
                
              ],
            ),
          )
        ),
      ),
    );
  }
}