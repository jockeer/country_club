import 'dart:io';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/providers/disciplina_provider.dart';
import 'package:country/services/disciplinas_service.dart';
import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisciplinaExtraPage extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final dynamic disciplina = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DisciplinaProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: (provider.menuAlto)?colores.verdeClaro:Colors.white,
        extendBodyBehindAppBar: true,
        appBar: appBarWidget(titulo: disciplina["nombreDisciplina"], color: (provider.menuAlto)?colores.verdeClaro:Colors.transparent, texto: Colors.white, arrowClaro: true, 
        logoClaro: (provider.menuAlto)?false:true,),

        body:  Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              (provider.menuAlto)
              ? Container()
              :Image(image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${disciplina["foto"]}')),
              
              _MenuPrincipal(disciplina: disciplina,)
            ],
          ),
        )


      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {

  final dynamic disciplina;

  _MenuPrincipal( {@required this.disciplina} );
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DisciplinaProvider>(context);
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:Radius.circular(50) ),
        child: Container(
          padding: EdgeInsets.only( top: 20),
          height: (provider.menuAlto)?size.height*0.85 : size.height*0.65,
          width: size.width,
          color: Colors.white,

          child: DefaultTabController(
            
            length: (disciplina["nombreDisciplina"]=='FRONT??N')?2:3,
            child: Column(
              children: [
                TabBar(
                  enableFeedback: false,
                  onTap: (value){
                    if (value==2||value==4) {
                      provider.menuAlto =true;
                    }else{
                      provider.menuAlto =false;

                    }
                  },
                  isScrollable: false,
                  indicatorColor: Colors.green,
                  indicatorWeight: 2.0,
                  labelColor: Colors.black,
                  tabs: (disciplina["nombreDisciplina"]=='FRONT??N')
                  ? [
                    Tab(child: Text('Horarios', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Coordinacion', style: TextStyle(fontWeight: FontWeight.bold),),),
                    ]
                  :[
                    Tab(child: Text('Horarios', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Profesores', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Reglamento', style: TextStyle(fontWeight: FontWeight.bold),),)
                    ]
                  ,
                  

                ),
                Expanded(
                  child: TabBarView(
                    children: (disciplina["nombreDisciplina"]=='FRONT??N')
                    ?[
                      _Horarios(),
                      _Profesores(disciplina: this.disciplina,),
                    ]
                    : [
                      _Horarios(),
                      _Profesores(disciplina: this.disciplina,),
                      _Reglamento()
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _Profesores extends StatelessWidget {
  final estilos = EstilosApp();
  final disciplinasService = DisciplinasService();
  final dynamic disciplina;

  _Profesores({ @required this.disciplina });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: disciplinasService.obetenerProfesores(this.disciplina["id"]),
      builder: ( _, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: ( _ , index){
              return  Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Container(
                            height: (snapshot.data[index]["foto"]==""|| snapshot.data[index]["foto"]==null)?0:120,    
                            width: (snapshot.data[index]["foto"]==""|| snapshot.data[index]["foto"]==null)?0:120,
                            child: (snapshot.data[index]["foto"]==""|| snapshot.data[index]["foto"]==null)
                            ? Container() 
                            :Image(image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/profesores/${snapshot.data[index]["foto"]}'),fit: BoxFit.cover,)
                          ),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 3,),
                              Text('${snapshot.data[index]["nombre"]} ${snapshot.data[index]["apellido"]}', style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 3,),
                              Text('${snapshot.data[index]["descripcion"]}', style: TextStyle(),),
                              SizedBox(height: 3,),
                              GestureDetector(
                                onTap: (){
                                  abrirWhatassp(snapshot.data[index]["telefono"]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: ColoresApp().naranjaClaro,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(snapshot.data[index]["telefono"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider()
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  void abrirWhatassp(String telefono)async{
    var whatsappUrl ="whatsapp://send?phone=591$telefono";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}

class Handicap extends StatefulWidget {

  @override
  _HandicapState createState() => _HandicapState();
}

class _HandicapState extends State<Handicap> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }
  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: "https://fbg.bo.plus.golf/handicap/",
        javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class _Reglamento extends StatelessWidget {
  final _pdfService = PdfService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF('https://laspalmascountryclub.com.bo/laspalmas/user-files/publicity/pdf/20210708155912xavcastllhallw.pdf'),
      builder: (context,AsyncSnapshot snapshot){
        print(snapshot.data);
        if (snapshot.hasData) {
          if(snapshot.data == 'error'){
            return Center(child: Text('Error al cargar archivo!', style: TextStyle(fontWeight: FontWeight.bold ),),);
          }
          return Container(
            child: PDFView(
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
class _Horarios extends StatelessWidget {
  final _pdfService = PdfService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF('https://laspalmascountryclub.com.bo/laspalmas/user-files/publicity/pdf/20210708155912xavcastllhallw.pdf'),
      builder: (context,AsyncSnapshot snapshot){
        print(snapshot.data);
        if (snapshot.hasData) {
          if(snapshot.data == 'error'){
            return Center(child: Text('Error al cargar archivo!', style: TextStyle(fontWeight: FontWeight.bold ),),);
          }
          return Container(
            child: PDFView(
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