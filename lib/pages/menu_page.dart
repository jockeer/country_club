import 'package:country/helpers/datos_constantes.dart';
import 'package:country/services/menu_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final _menuService = MenuService();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Menu'),
      body: FutureBuilder(
          future: _menuService.obtenerMenu(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return _Menu(
                lista: snapshot.data,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class _Menu extends StatelessWidget {
  final List<dynamic> lista;
  final colores = ColoresApp();
  _Menu({@required this.lista});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: lista.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: colores.verdeOscuro,
            isScrollable: true,
            labelColor: Colors.black,
            tabs: lista.map((categoria) {
              return Tab(
                child: Text(
                  categoria["categoria"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: lista.map((menu) {
                return Center(
                  child: _ImagenMenu(
                    img: menu["img"],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class _ImagenMenu extends StatelessWidget {
  final String img;

  _ImagenMenu({@required this.img});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FadeInImage(
            placeholder: AssetImage(
              'assets/images/fondocarga.png',
            ),
            image: NetworkImage(
                'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/$img')),
      ],
    );
  }
}
