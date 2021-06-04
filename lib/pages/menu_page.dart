import 'package:flutter/material.dart';

import 'package:country/widgets/menu_lateral_widget.dart';

class MenuPage extends StatelessWidget {
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
              _InputMenu(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _Menu(),
              ),
              SizedBox(height: 50.0,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(Icons.menu, color: Colors.black,),
        onPressed: ()=> _scaffoldKey.currentState.openDrawer(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Plato principal', style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 18.0 ),),
        ),
        Row(
          children: [
            _ButtonMenu(titulo: "Hamburguesa con queso y papas fritas", img: 'Menu', precio: '25',),
            _ButtonMenu(titulo: "Milanesa Picada", img: 'Menu', precio: '35',),
          ],
        ),
        Row(    
          children: [
            _ButtonMenu(titulo: "Pizza familiar 4 quesos", img: 'Menu', precio: '80',),
            _ButtonMenu(titulo: "Piquemacho especial", img: 'Menu', precio: '80',),
          ],
        ),
        Row(
          children: [
            _ButtonMenu(titulo: "Tallarines con chanpiñones", img: 'Menu', precio: '80',),
            _ButtonMenu(titulo: "Ensalada cesar", img: 'Menu', precio: '80',),
          ],
        ),
      ],
    );
  }
}


class _ButtonMenu extends StatelessWidget {

  final String titulo;
  final String img;
  final String precio;

  _ButtonMenu({@required this.titulo, @required this.img, @required this.precio});

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
              child: Card(
                elevation: 4.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(5.0),
                child: Container(
                  height: phoneSize.width*0.4,
                  child: Image(image: AssetImage('assets/images/${this.img}.png'), fit: BoxFit.cover,),
                ),
              )
          ),
          SizedBox(height: 10.0,),
          Text(this.titulo,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          Text('Bs.' + this.precio),
        ],
      ),
    );
  }
}

class _InputMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 80, right: 30.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: DropdownButton(
          underline: Container(height: 0.0,),
          isExpanded: true,
          value: "1",
          items: [
            DropdownMenuItem(child: Text('Menu - Cabaña La Palmera'),value: "1"),
            DropdownMenuItem(child: Text('Menu - Cabaña La Palmera'),value: "2"),
            DropdownMenuItem(child: Text('Menu - Cabaña La Palmera'),value: "3"),
          ],
          onChanged: (opt){
            print(opt);
          },
        ),
      ),
    );
  }
}