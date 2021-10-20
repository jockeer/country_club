import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/dependiente_model.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/services/socio_service.dart';

import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/compras_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TarjetaPage extends StatefulWidget {
  @override
  _TarjetaPageState createState() => _TarjetaPageState();
}

class _TarjetaPageState extends State<TarjetaPage> {
  final tarjetaService = TarjetaService();
  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final dynamic datos = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWidget(
            titulo: datos["nombre"],
            color: Colors.transparent,
            texto: Colors.white,
            arrowClaro: true,
            centrado: false,
            logo: false),
        extendBodyBehindAppBar: true,
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.4,
                color: colores.verdeOscuro,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bs. ' + '${datos["monto"]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.12),
                    ),
                    Text(
                      'Saldo',
                      style: TextStyle(
                          color: colores.verdeClaro,
                          fontSize: size.width * 0.04),
                    ),
                  ],
                ),
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
                      child: _UltimasTransacciones(
                        codigo: datos["codigo"],
                        datos: datos,
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}

class _UltimasTransacciones extends StatelessWidget {
  final _socioService = SocioService();
  final String codigo;
  final dynamic datos;
  _UltimasTransacciones({@required this.codigo, @required this.datos});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _socioService.obtenerDependientes(),
      builder: (_, AsyncSnapshot<List<Dependiente>> snapshot) {
        if (snapshot.hasData) {
          return _Menu(
            dependientes: snapshot.data,
            codigo: this.codigo,
            datos: this.datos,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Menu extends StatelessWidget {
  final List<Dependiente> dependientes;
  final colores = ColoresApp();
  final String codigo;
  final estilos = EstilosApp();
  final dynamic datos;

  _Menu(
      {@required this.dependientes,
      @required this.codigo,
      @required this.datos});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TarjetaProvider>(context, listen: false);
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TabBar(
            indicatorColor: colores.verdeOscuro,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Tarjetas',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.033),
                ),
              ),
              Tab(
                child: Text(
                  'Transacciones',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.033),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                (this.dependientes.length == 0)
                    ? Center(
                        child: Text('No tiene dependientes'),
                      )
                    : _Dependientes(
                        dependientes: dependientes,
                      ),
                _Transacciones(
                  codigo: this.codigo,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: ElevatedButton(
              onPressed: () {
                if (this.datos["titular"] == true) {
                  provider.tipoPago = 1;
                  provider.optRecarga = 1;
                  provider.montoRecarga = '10.00';
                  Navigator.pushNamed(context, 'metodo_pago');
                } else {
                  provider.tipoPago = 3;
                  provider.codigoTarjeta = this.datos["codigo"];
                  provider.optRecarga = 1;
                  provider.montoRecarga = '10.00';
                  provider.dependiente = this.datos["nombre"];
                  provider.ciDependiente = this.datos["ci"];
                  Navigator.pushNamed(context, 'metodo_pago');
                }
              },
              child: estilos.buttonChild(texto: 'RECARGAR'),
              style: estilos.buttonStyle(expanded: true),
            ),
          )
        ],
      ),
    );
  }
}

class _Transacciones extends StatelessWidget {
  final _tarjetaService = TarjetaService();
  final prefs = PreferenciasUsuario();
  final String codigo;
  _Transacciones({@required this.codigo});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tarjetaService.obtenerHistoricoComprasEspecifico(this.codigo),
      builder: (BuildContext context, AsyncSnapshot<List<Compra>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No tiene ninguna transacción realizada'),
            );
          }
          if (snapshot.data[0] == null) {
            return Center(
              child: Text('no tiene conexion a internet'),
            );
          }
          return ComprasWidget(compras: snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
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
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(
            dependientes[index].nombre,
            style: TextStyle(fontSize: 14.0),
          ),
          subtitle: Text(
            '${dependientes[index].apPaterno} ${dependientes[index].apMaterno} - ${dependientes[index].codigo}',
            style: TextStyle(fontSize: 12.0),
          ),
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
          trailing: Text('${dependientes[index].saldoTarjeta} Bs.'),
          onTap: () {
            provider.tipoPago = 3;
            provider.codigoTarjeta = dependientes[index].codigo;
            provider.optRecarga = 1;
            provider.montoRecarga = '10.00';
            provider.dependiente =
                '${dependientes[index].nombre} ${dependientes[index].apPaterno} ${dependientes[index].apMaterno}';
            provider.ciDependiente = dependientes[index].ci;
            Navigator.pushNamed(context, 'metodo_pago');
          },
        );
      },
    );
  }
}
