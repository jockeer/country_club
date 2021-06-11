import 'package:country/models/compra_model.dart';
import 'package:flutter/material.dart';

class CompraWidget extends StatelessWidget {

  final List<Compra> compras;
  CompraWidget({@required this.compras});

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
          title: Text(compras[index].area, style: TextStyle(fontSize: 14.0),),
          subtitle: Text(compras[index].fecha.substring(0,10)+ ' - Comprobante N ' +compras[index].idVenta , style: TextStyle(fontSize: 12.0),),
          trailing: Text(compras[index].totalVenta.toStringAsFixed(2) + ' Bs.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
        );
      },
    );
  }
}
