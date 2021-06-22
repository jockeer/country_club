import 'package:country/helpers/datos_constantes.dart';
// import 'package:country/providers/tarjeta_provider.dart';
// import 'package:country/models/credit_card_model.dart';
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
    final provider = Provider.of<TarjetasCreditoProvider>(context, listen: true);
    // provider.cargarTarjetas();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back), color: Colors.black,),
        title: Text('Administrar Tarjetas',style: TextStyle(color: Colors.black45),),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever,color: Colors.red),
            onPressed: ()async{
              final resultado = await DBService.db.deleteAll();
              if (resultado > 0) {
                mostrarSnackBar(context, 'Tarjetas Eliminadas');
                Navigator.pop(context);
                provider.tarjetaSeleccionada=0;
                DBService.db.getAllTarjetasPrueba(context);

                
              } else {
                mostrarSnackBar(context, 'No tiene ninguna tarjeta para eliminar');
              }


            }, 
          ),
        ],
      ),
      
      body: (provider.tarjetas[0]==null)
      ? Center(child: Text('No tiene ninguna tarjeta agregada'),)
      :Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Delize para eliminar una tarjeta'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.tarjetas.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  background: Container(color: Colors.red,),
                  onDismissed: (DismissDirection direction)async{
                    await DBService.db.deleteTarjeta(provider.tarjetas[index].id);
                    await DBService.db.getAllTarjetasPrueba(context);
                  },
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: Icon(Icons.credit_card, color: colores.verdeOscuro,),
                      subtitle: Text(provider.tarjetas[index].cardHolderName),
                      title: Text( '**** **** **** '+ provider.tarjetas[index].cardNumber.substring(provider.tarjetas[index].cardNumber.length-4)),
                      trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black,),
                    ),
                  ),
                );
              },
            ),
          ),
          Image(image: AssetImage('assets/icons/logo.png'),width: 200.0,),
          SizedBox(height: 20.0,)
        ],
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