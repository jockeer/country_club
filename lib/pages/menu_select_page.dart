import 'dart:io';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/services/menu_service.dart';
import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuSelectPage extends StatelessWidget {
  final _menuService = MenuService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
          titulo: 'MENÚ',
          color: Colors.transparent,
          texto: Colors.white,
          arrowClaro: true,
          logoClaro: true),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _menuService.obtenerMenu(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                        'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/banerMenu/${provider.menuSelect}'),
                    fit: BoxFit.fill,
                    height: size.height * 0.41,
                    width: size.width,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      child: Container(
                          width: size.width,
                          height: size.height * 0.65,
                          color: Colors.white,
                          child:
                              _Menu(lista: snapshot.data, provider: provider)),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Image(
          image: AssetImage('assets/icons/whatsapp.png'),
          width: 40,
        ),
        onPressed: () async {
          final whatsaapANDROID = "whatsapp://send?phone=59169051176";
          final whatsaapIOS = "https://wa.me/59169051176";
          if (Platform.isIOS) {
            await canLaunch(whatsaapIOS)
                ? await launch(whatsaapIOS, forceSafariVC: false)
                : print("instale whatsaap");
          } else {
            await canLaunch(whatsaapANDROID)
                ? await launch(whatsaapANDROID)
                : print('instale Whastaap');
          }
        },
      ),
    );
  }
}

class _Menu extends StatefulWidget {
  final List<dynamic> lista;
  final LoginProvider provider;
  _Menu({@required this.lista, @required this.provider});

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> with SingleTickerProviderStateMixin {
  final colores = ColoresApp();
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
        vsync: this,
        length: this.widget.lista.length,
        initialIndex: this.widget.provider.menu);

    super.initState();

    _tabController.addListener(() {
      cambio();
    });
  }

  void cambio() {
    print(_tabController.index);
    this.widget.provider.menuSelect =
        this.widget.lista[_tabController.index]["imgBaner"];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: this.widget.provider.menu,
      length: widget.lista.length,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TabBar(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            onTap: (value) {
              this.widget.provider.menuSelect =
                  this.widget.lista[value]["imgBaner"];
              // provider.menuSelect = int.parse(value.toString());
            },
            indicatorColor: colores.verdeClaro,
            isScrollable: true,
            labelColor: colores.verde,
            unselectedLabelColor: Colors.black,
            tabs: widget.lista.map((categoria) {
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
              controller: _tabController,
              children: widget.lista.map((menu) {
                return _ImagenMenu(
                  img: menu["img"],
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
  final _pdfService = PdfService();

  _ImagenMenu({@required this.img});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF(
          'https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/$img'),
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          if (snapshot.data == 'error') {
            return Center(
              child: Text(
                'Error al cargar archivo!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            child: PDFView(
              pageFling: false,
              pageSnap: false,
              filePath: snapshot.data.path,
              swipeHorizontal: false,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
