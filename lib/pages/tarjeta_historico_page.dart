import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/compra_model.dart';
import 'package:country/models/dependiente_model.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/compra_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoTarjetaPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
          titulo: 'TARJETA CONSUMO',
          color: Colors.transparent,
          texto: Colors.white,
          arrowClaro: true,
          logoClaro: true),
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image(
              image: AssetImage(
                  'assets/images/${provider.consumo == 0 ? 'Tarjeta_consumo.png' : 'tarjetaConsumo.jpg'}'),
              fit: BoxFit.fill,
              width: size.width,
              height: size.height * 0.4,
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
                    child: _UltimasTransacciones()),
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   key: _scaffoldKey,
    //   body: Column(
    //       children: [
    //         _Tarjeta(),
    //         Expanded(child: _UltimasTransacciones()),
    //       ],
    //     ),
    //   floatingActionButton: FloatingActionButton(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: Icon(Icons.arrow_back, color: Colors.white,),
    //     onPressed: (){
    //       Navigator.pop(context);
    //     },
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    // );
  }
}

class _UltimasTransacciones extends StatelessWidget {
  final _socioService = SocioService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return FutureBuilder(
      future: _socioService.obtenerDependientes(),
      builder: (_, AsyncSnapshot<List<Dependiente>> snapshot) {
        if (snapshot.hasData) {
          return _Menu(dependientes: snapshot.data, provider: provider);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Menu extends StatefulWidget {
  final List<Dependiente> dependientes;
  final LoginProvider provider;
  _Menu({@required this.dependientes, @required this.provider});

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> with SingleTickerProviderStateMixin {
  final colores = ColoresApp();
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        vsync: this, length: 2, initialIndex: this.widget.provider.consumo);

    super.initState();

    _tabController.addListener(() {
      cambio();
    });
  }

  void cambio() {
    print(_tabController.index);
    this.widget.provider.consumo = _tabController.index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<LoginProvider>(context);
    return DefaultTabController(
      initialIndex: provider.consumo,
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: colores.verdeOscuro,
            labelColor: Colors.black,
            onTap: (value) {
              provider.consumo = value;
            },
            tabs: [
              // Tab(child: Text('Mis transacciones', style: TextStyle(fontWeight: FontWeight.bold),),),
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
                  'Últimas Transacciones',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.033),
                ),
              ),
              // Tab(child: Text('Dependientes', style: TextStyle(fontWeight: FontWeight.bold),),),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                (this.widget.dependientes.length == 0)
                    ? Center(
                        child: Text('No tiene dependientes'),
                      )
                    : _Dependientes(
                        dependientes: widget.dependientes,
                      ),
                _Transacciones(),
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
      builder: (BuildContext context, AsyncSnapshot<List<Compra>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0] == null) {
            return Center(
              child: Text('no tiene conexion a internet'),
            );
          }
          return CompraWidget(compras: snapshot.data);
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
  final prefs = PreferenciasUsuario();
  final tarjetaService = TarjetaService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: dependientes.length,
      itemBuilder: (_, index) {
        if (index == 0) {
          return Column(
            children: [
              FutureBuilder(
                future: tarjetaService.obtenerSaldo(prefs.codigoSocio),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return ListTile(
                      title: Text(
                        prefs.nombreSocio,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      subtitle: Text(
                        prefs.apellidoSocio,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      // trailing: Icon(Icons.arrow_forward_ios, color: colores.verdeOscuro,),
                      trailing: Text(
                        '${snapshot.data} Bs.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, 'historico_dependiente',arguments: dependientes[index]);
                        Navigator.pushNamed(context, 'tarjeta', arguments: {
                          "codigo": prefs.codigoSocio,
                          "monto": snapshot.data,
                          "nombre":
                              '${prefs.nombreSocio} ${prefs.apellidoSocio}',
                          "titular": true,
                          "ci": prefs.ciSocio
                        });
                      },
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              ListTile(
                title: Text(
                  dependientes[index].nombre,
                  style: TextStyle(fontSize: 14.0),
                ),
                subtitle: Text(
                  '${dependientes[index].apPaterno} ${dependientes[index].apMaterno}',
                  style: TextStyle(fontSize: 12.0),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                // trailing: Icon(Icons.arrow_forward_ios, color: colores.verdeOscuro,),
                trailing: Text(
                  '${dependientes[index].saldoTarjeta} Bs.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onTap: () {
                  // Navigator.pushNamed(context, 'historico_dependiente',arguments: dependientes[index]);
                  Navigator.pushNamed(context, 'tarjeta', arguments: {
                    "codigo": dependientes[index].codigo,
                    "monto": dependientes[index].saldoTarjeta,
                    "nombre":
                        '${dependientes[index].nombre} ${dependientes[index].apPaterno} ${dependientes[index].apMaterno}',
                    "titular": false,
                    "ci": dependientes[index].ci
                  });
                },
              ),
            ],
          );
        } else {
          return ListTile(
            title: Text(
              dependientes[index].nombre,
              style: TextStyle(fontSize: 14.0),
            ),
            subtitle: Text(
              '${dependientes[index].apPaterno} ${dependientes[index].apMaterno}',
              style: TextStyle(fontSize: 12.0),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            // trailing: Icon(Icons.arrow_forward_ios, color: colores.verdeOscuro,),
            trailing: Text(
              '${dependientes[index].saldoTarjeta} Bs.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            onTap: () {
              // Navigator.pushNamed(context, 'historico_dependiente',arguments: dependientes[index]);
              Navigator.pushNamed(context, 'tarjeta', arguments: {
                "codigo": dependientes[index].codigo,
                "monto": dependientes[index].saldoTarjeta,
                "nombre":
                    '${dependientes[index].nombre} ${dependientes[index].apPaterno} ${dependientes[index].apMaterno}',
                "titular": false,
                "ci": dependientes[index].ci
              });
            },
          );
        }
      },
    );
  }
}
