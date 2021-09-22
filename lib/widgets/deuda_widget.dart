import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

import 'package:country/models/deudas_model.dart';

class DeudasWidget extends StatelessWidget {
  final List<Deuda> deudas;
  final colores = ColoresApp();

  DeudasWidget({@required this.deudas});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: deudas.length,
          itemBuilder: (context, index){
            return ListTileTheme(
              dense: true,
              child: Container(
                color: (index==0)?colores.verdeMarcador:Colors.white,
                child: ListTile(
                  title: Text(this.deudas[index].detalle, style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                  subtitle: Text('${this.deudas[index].fecha.substring(0,10)} - Comprobante N ${this.deudas[index].idDeuda} '),
                  trailing: Text('Bs. ${this.deudas[index].total.toStringAsFixed(2)}',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
                ),
              ),
            );
          },
        ),
    );
  }
}