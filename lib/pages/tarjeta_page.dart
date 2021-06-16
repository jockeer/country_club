import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';

import 'package:country/services/tarjeta_service.dart';
import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';


class TarjetaPage extends StatefulWidget {

  @override
  _TarjetaPageState createState() => _TarjetaPageState();
}

class _TarjetaPageState extends State<TarjetaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final tarjetaService = TarjetaService();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: RefreshIndicator(
        onRefresh: _refreshPuntos,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Tarjeta(),
              _UltimasTransacciones(),
              SizedBox(height: 20.0,),
              Text('Puedes recargar tu tarjeta', style: TextStyle(color: Colors.black45), ),
              SizedBox(height: 10.0,),
              _ButtonRecargar(),
              Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.menu, color: Colors.white,),
        onPressed: (){
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Future<void> _refreshPuntos() async {

    final prefs = PreferenciasUsuario();
    await tarjetaService.obtenerSaldo(prefs.codigoSocio);
    setState(() {
    });


  }
}

class _Tarjeta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final colores =ColoresApp();

    final phoneSize = MediaQuery.of(context).size;
    final prefs = PreferenciasUsuario();
    final tarjetaService = TarjetaService();

    return SafeArea(
      child: Container(
        width: phoneSize.width,
        height: phoneSize.height*0.4,
        color: colores.verdeOscuro,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: tarjetaService.obtenerSaldo(prefs.codigoSocio),
              builder: (context, AsyncSnapshot<String> snapshot){
                if (snapshot.hasData) {   
                  return Text('Bs.'+ '${snapshot.data}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: phoneSize.width*0.15, decoration: TextDecoration.underline),);          
                } 
                return CircularProgressIndicator();
              },
            ),
            Text('Tarjeta de consumo', style: TextStyle(color: Colors.white38, fontSize: phoneSize.width*0.05),),
          ],
        ),
      ),
    );
  }
}
class _UltimasTransacciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          color: Color(0xffC3C3C3),
          width: phoneSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 25.0),
            child: Text('Ultimas transacciones',style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),),
          ),
        ),
        Container(
          height: phoneSize.height*0.3,
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: [
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Reserva cancha de tenis'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 350', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Reserva Cabaña hoyo 19'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 450', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              
            ],
          ),
        )
      ],
    );
  }
}

class _ButtonRecargar extends StatelessWidget {

  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()async{
       Navigator.pushNamed(context, 'metodo_pago');
      //  Navigator.pushNamed(context, 'tarjeta_recarga');
      },
      child: estilos.buttonChild(texto: 'Recargar'),
      style: estilos.buttonStyle(),
    );
  }
}