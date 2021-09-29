import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/services/disciplinas_service.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisciplinaPage extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final dynamic disciplina = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar( backgroundColor: Colors.transparent, elevation: 0, title: Text(disciplina["nombreDisciplina"], style: TextStyle(fontWeight: FontWeight.bold),), centerTitle: true,),
        drawer: MenuLateralWidget(),
        body:  Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              FadeInImage(placeholder: AssetImage('assets/images/fondocarga.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${disciplina["foto"]}')),
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
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:Radius.circular(50) ),
        child: Container(
          padding: EdgeInsets.only( top: 20),
          height: size.height*0.65,
          width: size.width,
          color: Colors.white,

          child: DefaultTabController(
          
            length: 4,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.green,
                  indicatorWeight: 2.0,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(child: Text('Horarios', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Torneos', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Profesores', style: TextStyle(fontWeight: FontWeight.bold),),),
                    Tab(child: Text('Reglamento', style: TextStyle(fontWeight: FontWeight.bold),),),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('hola 1'),),
                      Center(child: Text('hola 2'),),
                      _Profesores(disciplina: this.disciplina,),
                      Center(child: Text('hola 2'),),
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
            itemCount: snapshot.data.length,
            itemBuilder: ( _ , index){
              return  Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      child: FadeInImage(placeholder: AssetImage('assets/icons/palmera.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/profesores/${snapshot.data[index]["foto"]}'),fit: BoxFit.cover,)
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        Text('${snapshot.data[index]["nombre"]} ${snapshot.data[index]["apellido"]}'),
                        ElevatedButton(
                          onPressed: (){
                            abrirWhatassp();
                          },
                          child: Text('${snapshot.data[index]["telefono"]}'),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  void abrirWhatassp()async{
    var whatsappUrl ="whatsapp://send?phone=59176597228";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}