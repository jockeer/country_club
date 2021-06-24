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

  final colores =ColoresApp();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: "Mensualidad"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: colores.gris,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pagos realizados', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
          _PagosHistorico(),        
          Container(
            width: double.infinity,
            color: colores.naranja,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pagos pendientes', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
          _DeudasHistorico(),

          
        ],
      )
    );
  }
}

class _PagosHistorico extends StatelessWidget {
  final colores =ColoresApp();

  @override
  Widget build(BuildContext context) {
    final _tarjetaService = TarjetaService();
    return FutureBuilder(
        future: _tarjetaService.obtenerHistoricoPagos(),
        builder: (context, AsyncSnapshot<List<Pago>> snapshot){
          if (snapshot.hasData) {
            return Expanded(
              child: Column(
                children: [
                  PagosWidget(pagos: snapshot.data),
                  Container(
                    width: double.infinity,
                    color: colores.verdeOscuro,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Pago reciente', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  ListTileTheme(
                    dense: true,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(snapshot.data[0].detalle, style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                        subtitle: Text('${snapshot.data[0].fecha.substring(0,10)} - Comprobante N ${snapshot.data[0].idPago}'),
                        trailing: Text('Bs. ${snapshot.data[0].totalPago.toStringAsFixed(2)}',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      );
  }
}

class _DeudasHistorico extends StatelessWidget {
  
  final _tarjetaService = TarjetaService();
  final colores =ColoresApp();
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final provider = Provider.of<TarjetaProvider>(context, listen: false);
    
    return SizedBox(
      height: phoneSize.height*0.3,
      child: FutureBuilder(
        future: _tarjetaService.obtenerHistoricoDeudas(),
        builder: (context, AsyncSnapshot<List<Deuda>> snapshot){
          if (snapshot.hasData) {
            return Column(
                children: [
                  DeudasWidget(deudas: snapshot.data),
                  Container(
                    color: colores.verdeOscuro,
                    child: ListTile(
                      title: Text('${snapshot.data[0].detalle}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 14.0)),
                      subtitle: Text('${snapshot.data[0].fecha.substring(0,10)} - Bs. ${snapshot.data[0].total.toStringAsFixed(2)}', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)),
                      trailing: ElevatedButton(
                        onPressed: (){
                          // Navigator.pushNamed(context, 'detalle_pago_membresia', arguments: snapshot.data[0]);
                          provider.tipoPago = 2;
                          provider.montoRecarga= snapshot.data[0].total.toStringAsFixed(2);
                          provider.optRecarga= 5;
                          provider.deuda= snapshot.data[0];
                          Navigator.pushNamed(context, 'metodo_pago');
                        }, 
                        child: estilos.buttonChild(texto: 'Pagar'),
                        style: ElevatedButton.styleFrom(
                          primary: colores.naranja,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
                        ),
                      ),
                    ),
                  )
                ],
              );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}




