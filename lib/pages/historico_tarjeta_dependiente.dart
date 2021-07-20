import 'package:country/models/compra_model.dart';
import 'package:country/models/dependiente_model.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/compra_widget.dart';
import 'package:flutter/material.dart';

class HistoricoTarjetaDependiente extends StatelessWidget {

  final _tarjetaService = TarjetaService();

  @override
  Widget build(BuildContext context) {
    final Dependiente dependiente = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBarWidget(titulo: dependiente.nombre),
      body: FutureBuilder(
        future: _tarjetaService.obtenerHistoricoCompras(dependiente.codigo),
        builder: (_, AsyncSnapshot<List<Compra>> snapshot){
          if (snapshot.hasData) {
            if (snapshot.data[0]==null) {
            return Center(child: Text('no tiene conexion a internet'),);
          }
            return CompraWidget(compras: snapshot.data);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}