import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateral(),
      body: SafeArea(
        child: Stack(
          children: [
            _FondoPantalla(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60.0,),
                  _Menu(),
                  Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
                ],
              ),
            )
          ],
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(Icons.menu, color: Colors.black,),
        onPressed: (){
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
     
  }
}

class _FondoPantalla extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/backgrounds/fondo_blanco.png'),
      height: phoneSize.height,
      fit: BoxFit.fill,
    );
  }

}

class MenuLateral extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      

    );
  }
}

class _Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              print('ss');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xff009D47)
              ),
              width: phoneSize.width,
              height: 100.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Historico de tarjeta', color: Colors.yellow),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Mensualidad', color: Colors.green)
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Menu', color: Colors.yellow),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Inbox', color: Colors.green)
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Reservas', color: Colors.yellow),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Historial de reservas', color: Colors.green)
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonMenu(titulo: 'Eventos', color: Colors.yellow),
              SizedBox(width: 10.0,),
              _ButtonMenu(titulo: 'Handicap', color: Colors.green)
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

  _ButtonMenu({@required this.titulo, @required this.color});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        onTap: (){
          print('ss');
        },
        child: Card(
          color: Color(0xff009D47),
          elevation: 10.0,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
          child: Container(         
            height: 100.0,
            child: Stack(
              children: [
                // _FondoPantalla(),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container( width: double.infinity,color: Colors.black38,child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(this.titulo, textAlign: TextAlign.right, style: TextStyle(color: Colors.white),),
                      )),
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