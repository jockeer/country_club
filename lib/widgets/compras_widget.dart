import 'package:country/models/compra_model.dart';
import 'package:flutter/material.dart';

class ComprasWidget extends StatelessWidget {

  final List<Compra> compras;
  ComprasWidget({@required this.compras});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: compras.length,
      itemBuilder: (context, index){
        return  ListTile(
          onTap: ()async{
            Navigator.pushNamed(context, 'detalle_compra',arguments: {"idVenta":compras[index].idVenta, "nombre":compras[index].area, "total": compras[index].totalVenta });
          },
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(compras[index].fecha.substring(0,10), style: TextStyle(fontSize: 11.0),),
            ],
          ),
          title: Text('Comprobante N ' +compras[index].idVenta, style: TextStyle(fontSize: 14.0),),
          // subtitle: Text(compras[index].nombre, style: TextStyle(fontSize: 11.0),),
          trailing: Text(compras[index].totalVenta.toStringAsFixed(2) + ' Bs.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
        );
      },
    );
  }
}
