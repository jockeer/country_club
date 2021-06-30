import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/detalle_compra_model.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class DetalleCompraPage extends StatelessWidget {
  final _tarjetaService = TarjetaService();

  @override
  Widget build(BuildContext context) {

    final Map<String,dynamic> idVenta = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Detalle - ${idVenta["idVenta"]}'),
      body: FutureBuilder(
        future: _tarjetaService.obtenerDetalleCompra(idVenta["idVenta"]),
        builder: (context , AsyncSnapshot<List<DetalleCompra>> snapshot){
          if (snapshot.hasData) {
            if (snapshot.data[0]==null) {
              return Center(child: Text('Revise su conexion a internet'),);
            }
            return _DetalleCompra(compras: snapshot.data, area: idVenta["nombre"], totalVenta: idVenta["total"] );
          } else {
            return Center(child: CircularProgressIndicator() );
          }
        },
      ),
    );
  }
}

class _DetalleCompra extends StatelessWidget {
  final List<DetalleCompra> compras;
  final String area;
  final double totalVenta;
  final colores = ColoresApp();

  _DetalleCompra({@required this.compras, @required this.area, @required this.totalVenta});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Text(this.area, style: TextStyle(color: colores.verdeOscuro, fontWeight: FontWeight.bold, fontSize: 18.0)),
        ),
        Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: compras.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(compras[index].producto,style: TextStyle(fontSize: 14.0,),),
                subtitle: Text('cantidad: ' + compras[index].cantidad.toString() + ' - precio: ' +compras[index].subTotal.toStringAsFixed(2) + ' Bs.' ),
                leading: Text("${index + 1}.",style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text(compras[index].subTotal.toStringAsFixed(2) + ' Bs.', style: TextStyle(fontWeight: FontWeight.bold),),
              );
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.attach_money_outlined, color: Colors.black,),
          trailing: Text('Total: ' +  this.totalVenta.toStringAsFixed(2) + ' Bs.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
        )
      ],
    );
  }
}