import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/deudas_model.dart';
import 'package:country/models/pagos_model.dart';
import 'package:country/providers/tarjeta_provider.dart';

import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/deuda_widget.dart';
import 'package:country/widgets/pago_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MensualidadPage extends StatelessWidget {
  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWidget(
          titulo: 'MENSUALIDADES',
          color: colores.verdeClaro,
          texto: Colors.white,
          arrowClaro: true),
      backgroundColor: colores.verdeClaro,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
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
                    height: size.height * 0.85,
                    color: Colors.white,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TabBar(
                            indicatorColor: colores.verde,
                            indicatorWeight: 4.0,
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Pagos Pendientes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Pagos Realizados',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [_DeudasHistorico(), _PagosHistorico()],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PagosHistorico extends StatelessWidget {
  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final _tarjetaService = TarjetaService();
    return FutureBuilder(
      future: _tarjetaService.obtenerHistoricoPagos(),
      builder: (context, AsyncSnapshot<List<Pago>> snapshot) {
        if (snapshot.hasData) {
          return PagosWidget(pagos: snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _DeudasHistorico extends StatelessWidget {
  final _tarjetaService = TarjetaService();
  final colores = ColoresApp();
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context, listen: false);

    return FutureBuilder(
      future: _tarjetaService.obtenerHistoricoDeudas(),
      builder: (context, AsyncSnapshot<List<Deuda>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                DeudasWidget(deudas: snapshot.data),
                Divider(
                  thickness: 2,
                  color: colores.verdeClaro,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalle',
                        style: TextStyle(
                            fontSize: 16,
                            color: colores.verdeOscuro,
                            fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                          title: Text('${snapshot.data[0].detalle}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0)),
                          subtitle: Text(
                              '${snapshot.data[0].fecha.substring(0, 10)}',
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          trailing: Text(
                              'Bs. ${snapshot.data[0].total.toStringAsFixed(2)}')),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, 'detalle_pago_membresia', arguments: snapshot.data[0]);
                              provider.tipoPago = 2;
                              provider.montoRecarga =
                                  snapshot.data[0].total.toStringAsFixed(2);
                              provider.optRecarga = 5;
                              provider.deuda = snapshot.data[0];
                              Navigator.pushNamed(context, 'metodo_pago');
                            },
                            child: estilos.buttonChild(texto: 'Pagar'),
                            style: estilos.buttonStyle(expanded: true)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
