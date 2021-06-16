import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjetas_credito_provider.dart';

import 'package:country/services/database_service.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdministrarTarjetasPage extends StatefulWidget {
  @override
  _AdministrarTarjetasPageState createState() => _AdministrarTarjetasPageState();
}

class _AdministrarTarjetasPageState extends State<AdministrarTarjetasPage> {
  final colores = ColoresApp();
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context, listen: false);
    provider.cargarTarjetas();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(),
        title: Text('Administrar Tarjetas',style: TextStyle(color: Colors.black45),),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever,color: Colors.red),
            onPressed: ()async{
              await DBService.db.deleteAll();
              mostrarSnackBar(context, 'Tarjetas Eliminadas');
              Navigator.pop(context);

            }, 
          ),
        ],
      ),
      
      body: ListView.builder(
          itemCount: provider.tarjetas.length,
          itemBuilder: (context, index){
            if (provider.tarjetas.length==0) {
              return Center(child: Text('No tiene ninguna tarjeta agregada'),);
            }
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              background: Container(color: Colors.red,),
              onDismissed: (DismissDirection direction){
              
              },
              child: ListTile(
                leading: Icon(Icons.credit_card, color: Colors.green,),
                title: Text(provider.tarjetas[index].cardHolderName),
                subtitle: Text(provider.tarjetas[index].cardNumber),
              ),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: colores.verdeOscuro,
        onPressed: (){
          Navigator.pushNamed(context, 'nueva_tarjeta_credito');
        },
      ),
    );
  }
}