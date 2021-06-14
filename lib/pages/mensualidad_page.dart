import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/pagos_model.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pago_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/menu_lateral_widget.dart';

class MensualidadPage extends StatelessWidget {

  final colores =ColoresApp();

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: "Mensualidad"),
      drawer: MenuLateralWidget(),
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
            color: colores.verdeOscuro,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pago reciente', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
          ListTileTheme(
            dense: true,
            child: ListTile(
              title: Text('Pago realizado en Febrero', style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
              subtitle: Text('10/02/2021 - Comprobante N 450313'),
              trailing: Text('Bs. 450',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
            ),
          ),
          Container(
            width: double.infinity,
            color: colores.naranja,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pagos pendientes', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
          Expanded(
            child: ListView(
                children: [
                  ListTileTheme(
                    dense: true,
                    child: ListTile(
                      title: Text('Mensualidad de Marzo', style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                      subtitle: Text('10/02/2021 - Comprobante N 450313'),
                      trailing: Text('Bs. 450',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
                      tileColor: colores.naranjaClaro,
                    ),
                  ),
                  ListTileTheme(
                    dense: true,
                    child: ListTile(
                      title: Text('Mensualidad de Abril', style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                      subtitle: Text('10/02/2021 - Comprobante N 450313'),
                      trailing: Text('Bs. 450',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
          ),
         
          // Expanded(child: Container()),
          ListTile(
            tileColor: colores.verdeOscuro,
            title: Text('Mensualidad Marzo 2021', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
            subtitle: Text('Bs. 450.00', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)),
            trailing: ElevatedButton(
              onPressed: (){}, 
              child: Text('Pagar'),
              style: ElevatedButton.styleFrom(
                primary: colores.naranja,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
              ),
            ),
          )
        ],
      )
    );
  }
}

class _PagosHistorico extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final _tarjetaService = TarjetaService();
    return SizedBox(
      height: phoneSize.height*0.35,
      child: FutureBuilder(
        future: _tarjetaService.obtenerHistoricoPagos(),
        builder: (context, AsyncSnapshot<List<Pago>> snapshot){
          if (snapshot.hasData) {
            return PagosWidget(pagos: snapshot.data);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}


