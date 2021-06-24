import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/compra_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';

class HistoricoTarjetaPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Tarjeta(),
            _UltimasTransacciones(),
            PieLogoWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _Tarjeta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;


    return SafeArea(
      child: Container(
        width: phoneSize.width,
        height: phoneSize.height*0.35,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Tarjeta_consumo.png'),fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Text('Tarjeta de consumo', style: TextStyle(color: Colors.white38, fontSize: phoneSize.width*0.06),),
          ],
        ),
      ),
    );
  }
}

class _UltimasTransacciones extends StatelessWidget {

  final _tarjetaService = TarjetaService();
  final prefs = PreferenciasUsuario();

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
          height: phoneSize.height*0.45,
          child: FutureBuilder(
            future: _tarjetaService.obtenerHistoricoCompras(prefs.codigoSocio),
            builder: (BuildContext context, AsyncSnapshot<List<Compra>> snapshot ){
              if (snapshot.hasData) {
                if (snapshot.data[0]==null) {
                  return Center(child: Text('no tiene conexion a internet'),);
                }
                return CompraWidget(compras: snapshot.data);
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        )
        
      ],
    );
  }
}