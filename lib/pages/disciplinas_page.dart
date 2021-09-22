import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/services/disciplinas_service.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';

class DisciplinasPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Image(image: AssetImage('assets/backgrounds/fondo_menu.jpg')),
              _MenuPrincipal()
            ],
          ),
        )
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Icon(Icons.menu, color: Colors.white,),
            onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Container(child: Text('Hola ${prefs.nombreSocio}!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _MenuPrincipal extends StatelessWidget {

  final disciplinasService = DisciplinasService();
  final colores= ColoresApp();

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
          padding: EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 0),
          height: size.height*0.65,
          width: size.width,
          color: Colors.white,
          child: FutureBuilder(
            future: disciplinasService.obtenerDisciplinas(),
            builder: ( _ , AsyncSnapshot snapshot ){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: ( _ , index){
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'disciplina', arguments: snapshot.data[index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeInImage(placeholder: AssetImage('assets/icons/palmera.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/disciplinas/${snapshot.data[index]["logo"]}'), width: 40,),
                              SizedBox(width: 20,),
                              Text(snapshot.data[index]["nombreDisciplina"], style: TextStyle( color: colores.verdeOscuro, fontWeight: FontWeight.bold, fontSize: 16 ),)
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: colores.verdeOscuro, height: 25,)
                      ],
                    );
                  },
                );  
              }
              return Center(child: CircularProgressIndicator(),);

            },
          )
        ),
      ),
    );
  }
}