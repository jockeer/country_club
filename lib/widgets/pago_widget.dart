import 'package:country/models/pagos_model.dart';
import 'package:flutter/material.dart';

class PagosWidget extends StatelessWidget {
  final List<Pago> pagos;

  PagosWidget({@required this.pagos});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: pagos.length,
        itemBuilder: (context, index){
          return ListTileTheme(
            dense: true,
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(this.pagos[index].detalle, style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0)),
                subtitle: Text('${this.pagos[index].fecha.substring(0,10)} - Comprobante N ${this.pagos[index].idPago} '),
                trailing: Text('Bs. ${this.pagos[index].totalPago.toStringAsFixed(2)}',style:TextStyle(color:Colors.black54, fontWeight: FontWeight.w600)),
              ),
            ),
          );
        },
      ),
    );
  }
}