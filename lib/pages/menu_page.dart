import 'package:country/helpers/datos_constantes.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/menu_lateral_widget.dart';

class MenuPage extends StatelessWidget {
  final categorias =['Desayunos','Sopas','Ensaladas','Pastas','Aves','Res','Pescado & Mariscos','Tipicos','Sandwichs','Hamburguesas','Milanesas','Postres','Masitas','Bebidas'];
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Menu'),
      drawer: MenuLateralWidget(),
<<<<<<< HEAD
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _InputMenu(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _Menu(),
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
=======
      body: DefaultTabController(
        length: categorias.length,
        child: Column(
          children: [
            TabBar(
              indicatorColor: colores.verdeOscuro,
              isScrollable: true,
              labelColor: Colors.black,
            
             
              tabs: [
                Tab(text: 'Desayunos',),
                Tab(text: 'Sopas',),
                Tab(text: 'Ensaladas',),
                Tab(text: 'Pastas',),
                Tab(text: 'Aves',),
                Tab(text: 'Res',),
                Tab(text: 'Pescado & Mariscos',),
                Tab(text: 'Tipicos',),
                Tab(text: 'Sandwichs',),
                Tab(text: 'Hamburguesas',),
                Tab(text: 'Milanesas',),
                Tab(text: 'Postres',),
                Tab(text: 'Masitas',),
                Tab(text: 'Bebidas',),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child:_Desayunos(),),
                  Center(child: _Sopas(),),
                  Center(child: _Ensaladas(),),
                  Center(child: _Pastas(),),
                  Center(child: _Aves(),),
                  Center(child: _Res(),),
                  Center(child: _Pescado(),),
                  Center(child: _Tipico(),),
                  Center(child: _Sandwich(),),
                  Center(child: _Hamburguesas(),),
                  Center(child: _Milanesa(),),
                  Center(child: _Postres(),),
                  Center(child: _Masitas(),),
                  Center(child: _Bebidas(),),
    );
  }
}

<<<<<<< HEAD
class _Menu extends StatelessWidget {
=======

class _Desayunos extends StatelessWidget {

>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
<<<<<<< HEAD
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Plato principal',
            style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
                fontSize: 18.0),
          ),
        ),
        Row(
          children: [
            _ButtonMenu(
              titulo: "Hamburguesa con queso y papas fritas",
              img: 'Menu',
              precio: '25',
            ),
            _ButtonMenu(
              titulo: "Milanesa Picada",
              img: 'Menu',
              precio: '35',
            ),
          ],
        ),
        Row(
          children: [
            _ButtonMenu(
              titulo: "Pizza familiar 4 quesos",
              img: 'Menu',
              precio: '80',
            ),
            _ButtonMenu(
              titulo: "Piquemacho especial",
              img: 'Menu',
              precio: '80',
            ),
          ],
        ),
        Row(
          children: [
            _ButtonMenu(
              titulo: "Tallarines con chanpiñones",
              img: 'Menu',
              precio: '80',
            ),
            _ButtonMenu(
              titulo: "Ensalada cesar",
              img: 'Menu',
              precio: '80',
            ),
          ],
        ),
=======
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png',), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/desayunos.jpg')),       
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
      ],
    );
  }
}
class _Sopas extends StatelessWidget {

<<<<<<< HEAD
class _ButtonMenu extends StatelessWidget {
  final String titulo;
  final String img;
  final String precio;

  _ButtonMenu(
      {@required this.titulo, @required this.img, @required this.precio});

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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(5.0),
            child: Container(
              height: phoneSize.width * 0.4,
              child: Image(
                image: AssetImage('assets/images/${this.img}.png'),
                fit: BoxFit.cover,
              ),
            ),
          )),
          SizedBox(
            height: 10.0,
          ),
          Text(
            this.titulo,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Bs .' + this.precio),
        ],
      ),
=======
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/sopas.jpg'))
      ],
    );
  }
}
class _Ensaladas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/ensaladas.jpg'))
      ],
    );
  }
}
class _Pastas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/pastas.jpg'))
      ],
    );
  }
}
class _Aves extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/aves.jpg'))
      ],
    );
  }
}
class _Res extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/res.jpg'))
      ],
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
    );
  }
}
class _Pescado extends StatelessWidget {

<<<<<<< HEAD
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
          underline: Container(
            height: 0.0,
          ),
          isExpanded: true,
          value: "1",
          items: [
            DropdownMenuItem(
                child: Text('Menu - Cabaña La Palmera'), value: "1"),
            DropdownMenuItem(
                child: Text('Menu - Cabaña La Palmera'), value: "2"),
            DropdownMenuItem(
                child: Text('Menu - Cabaña La Palmera'), value: "3"),
          ],
          onChanged: (opt) {
            print(opt);
          },
        ),
      ),
=======
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/pescado.jpg'))
      ],
    );
  }
}
class _Tipico extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/tipicos.jpg'))
      ],
    );
  }
}
class _Sandwich extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/sandwiches.jpg'))
      ],
    );
  }
}
class _Hamburguesas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/hamburguesas.jpg'))
      ],
    );
  }
}
class _Milanesa extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/milanesas.jpg'))
      ],
    );
  }
}
class _Postres extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/postres.jpg'))
      ],
    );
  }
}
class _Masitas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/masitas.jpg'))
      ],
    );
  }
}
class _Bebidas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/bebidas.jpg'))
      ],
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
    );
  }
}
