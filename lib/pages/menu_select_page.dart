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
        backgroundColor: Colors.black,
        appBar: appBarWidget(titulo: 'MENÚ', color: Colors.transparent,texto: Colors.white, arrowClaro: true),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
          future: _menuService.obtenerMenu(),
          builder: ( _ , AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              return Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    Image(image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/banerMenu/${provider.menuSelect}'),fit: BoxFit.fill, height: size.height*0.41, width: size.width,),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        child: Container(
                          width: size.width,
                          height: size.height*0.65,
                          color: Colors.white,
                          child: _Menu(
                            lista: snapshot.data,
                          )
                        ),
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
          child: Image(image: AssetImage('assets/icons/whatsapp.png'),width: 40,),
          onPressed: ()async{
            var whatsappUrl ="whatsapp://send?phone=59169051176&text=Me%20gustaria%20hacer%20un%20pedido";
            await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
          },
        ),
      );
  }
}

class _Menu extends StatelessWidget {
  final List<dynamic> lista;
  final colores = ColoresApp();
  _Menu({@required this.lista});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return DefaultTabController(
      initialIndex: provider.menu,
      length: lista.length,
      child: Column(
        children: [
          SizedBox(height: 30,),
          TabBar(
            physics: BouncingScrollPhysics(),
            onTap: (value){
              provider.menuSelect = this.lista[value]["imgBaner"];
              // provider.menuSelect = int.parse(value.toString());
            },
            indicatorColor: colores.verdeClaro,
            isScrollable: true,
            labelColor: colores.verde,
            unselectedLabelColor: Colors.black,
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
                return  _ImagenMenu(
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
      future: _pdfService.loadPDF('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/menu/$img'),
      builder: (context,AsyncSnapshot snapshot){
        print(snapshot.data);
        if (snapshot.hasData) {
          if(snapshot.data == 'error'){
            return Center(child: Text('Error al cargar archivo!', style: TextStyle(fontWeight: FontWeight.bold ),),);
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
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}