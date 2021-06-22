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
              
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}


class _Desayunos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(placeholder: AssetImage('assets/icons/logo.png',), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/desayunos.jpg')),       
      ],
    );
  }
}
class _Sopas extends StatelessWidget {

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
    );
  }
}
class _Pescado extends StatelessWidget {

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
    );
  }
}