import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/dependiente_model.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/services/socio_service.dart';

import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/compra_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


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
      body: RefreshIndicator(
        onRefresh: _refreshPuntos,
        child: Column(
            children: [
              _Tarjeta(),
              Expanded(child: _UltimasTransacciones()),
              SizedBox(height: 20.0,),
              Text('Puedes recargar tu tarjeta', style: TextStyle(color: Colors.black45), ),
              SizedBox(height: 10.0,),
              _ButtonRecargar(),
              SizedBox(height: 20.0,),
            ],
          )
        
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
        height: phoneSize.height*0.35,
        color: colores.verdeOscuro,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: tarjetaService.obtenerSaldo(prefs.codigoSocio),
              builder: (context, AsyncSnapshot<String> snapshot){
                if (snapshot.hasData) {   
                  return Text('Bs. '+ '${snapshot.data}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: phoneSize.width*0.12, decoration: TextDecoration.underline),);          
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
  final _socioService = SocioService();
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _socioService.obtenerDependientes(),
      builder: (_, AsyncSnapshot<List<Dependiente>> snapshot){
        if (snapshot.hasData) {
            return _Menu(dependientes: snapshot.data,);
          }
          return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

class _Menu extends StatelessWidget {
  final List<Dependiente> dependientes;
  final colores = ColoresApp();

  _Menu({@required this.dependientes});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: colores.verdeOscuro,
            labelColor: Colors.black,
            tabs: [
              Tab(child: Text('Ultimas transacciones', style: TextStyle(fontWeight: FontWeight.bold),),),
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dependientes', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 6,),
                  Icon(Icons.credit_card)
                ],
              ),),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _Transacciones(),
                (this.dependientes.length == 0)
                ? Center(child: Text('No tiene dependientes'),)
                :_Dependientes(dependientes: dependientes,),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Transacciones extends StatelessWidget {
  final _tarjetaService = TarjetaService();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
class _Dependientes extends StatelessWidget {
  final List<Dependiente> dependientes;
  final colores = ColoresApp();

  _Dependientes({@required this.dependientes});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context, listen: false);
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: dependientes.length,
      itemBuilder: ( _ , index ){
        return ListTile(
          title: Text(dependientes[index].nombre, style: TextStyle(fontSize: 14.0),),
          subtitle: Text('${dependientes[index].apPaterno} ${dependientes[index].apMaterno} - ${dependientes[index].codigo}', style: TextStyle(fontSize: 12.0),),
          leading: Icon(Icons.person, color: Colors.black,),
          trailing: Text('${dependientes[index].saldoTarjeta} Bs.'),
          
          onTap: (){
            provider.tipoPago=3;
            provider.codigoTarjeta = dependientes[index].codigo;
            provider.optRecarga=1;
            provider.montoRecarga='10.00';
            provider.dependiente = '${dependientes[index].nombre} ${dependientes[index].apPaterno} ${dependientes[index].apMaterno}';
            provider.ciDependiente= dependientes[index].ci;
            Navigator.pushNamed(context, 'metodo_pago');
          },
        );
      },
    );
  }
}

class _ButtonRecargar extends StatelessWidget {

  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context, listen: false);
    return ElevatedButton(
      onPressed: ()async{
        provider.tipoPago=1;
        provider.optRecarga=1;
        provider.montoRecarga='10.00';
        Navigator.pushNamed(context, 'metodo_pago');
      //  Navigator.pushNamed(context, 'tarjeta_recarga');
      },
      child: estilos.buttonChild(texto: 'Recargar'),
      style: estilos.buttonStyle(),
    );
  }
}