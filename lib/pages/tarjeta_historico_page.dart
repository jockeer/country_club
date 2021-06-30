import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/socio_model.dart';
import 'package:country/services/socio_service.dart';
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
      body: Column(
          children: [
            _Tarjeta(),
            Expanded(child: _UltimasTransacciones()),
            PieLogoWidget()
          ],
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
        builder: (_, AsyncSnapshot<List<Socio>> snapshot){
          if (snapshot.hasData) {
            return _Menu(dependientes: snapshot.data,);
          }
          return Center(child: CircularProgressIndicator(),);
        },
    );
  }
}

class _Menu extends StatelessWidget {
  final List<Socio> dependientes;
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
              Tab(child: Text('Mis transacciones', style: TextStyle(fontWeight: FontWeight.bold),),),
              Tab(child: Text('Dependientes', style: TextStyle(fontWeight: FontWeight.bold),),),
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
  final List<Socio> dependientes;
  final colores = ColoresApp();
  _Dependientes({@required this.dependientes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: dependientes.length,
      itemBuilder: ( _ , index ){
        return ListTile(
          title: Text(dependientes[index].nombre, style: TextStyle(fontSize: 14.0),),
          subtitle: Text('${dependientes[index].apPaterno} ${dependientes[index].apMaterno}', style: TextStyle(fontSize: 12.0),),
          leading: Icon(Icons.person, color: Colors.black,),
          trailing: Icon(Icons.arrow_forward_ios, color: colores.verdeOscuro,),
          onTap: (){
            Navigator.pushNamed(context, 'historico_dependiente',arguments: dependientes[index]);
          },
        );
      },
    );
  }
}