import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/deudas_model.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DetallePagoMembresia extends StatelessWidget {
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
  final Deuda deuda = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Detalle Transaccion'),
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0,),
              Text('Ultimo paso!',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
              Divider(),
              ListTile(
                title: Text('Codigo:',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(deuda.codigo.toString(),style: TextStyle(fontSize: 12.0, ),),
              ),
              Divider(),
              ListTile(
                title: Text('Detalle:',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(deuda.detalle,style: TextStyle(fontSize: 12.0, ),),
              ),
              Divider(),
              ListTile(
                title: Text('tipo:',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(deuda.tipo,style: TextStyle(fontSize: 12.0, ),),
              ),
              Divider(),
              ListTile(
                title: Text('fecha:',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(deuda.fecha.substring(0,10),style: TextStyle(fontSize: 12.0, ),),
              ),
              Divider(),
              ListTile(
                title: Text('total:',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(deuda.total.toStringAsFixed(2) + ' Bs.',style: TextStyle(fontSize: 12.0, ),),
              ),
              Divider(),

              Expanded(child: Container()),
              ElevatedButton(
                child: estilos.buttonChild(texto: 'Realizar pago'),
                style: estilos.buttonStyle(),
                onPressed: (){
                  
                },
              ),
              SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }
}