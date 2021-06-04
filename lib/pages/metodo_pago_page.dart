import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetodoPagoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Tarjeta(),
            _Titulos(),
            _Opciones(),
            SizedBox(height: 20.0,),
            _ButtonNext(),
            SizedBox(height: 30.0,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }
}


class _Tarjeta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: phoneSize.width,
        height: phoneSize.height*0.35,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo_pago.png'),fit: BoxFit.fill)),
      ),
    );
  }
}

class _Titulos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final colores= ColoresApp();
    return Column(
      children: [
        Container(
          height: phoneSize.height * 0.1,
          width: double.infinity,
          color: colores.verdeOscuro,
          child: Center(child: Text('Modo de Pago', style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: phoneSize.height * 0.05,
          width: double.infinity,
          color: colores.naranjaClaro,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Seleccione...', style: TextStyle(color: Colors.white,fontSize: 20.0)),
                Icon(Icons.arrow_drop_down_outlined, color: Colors.white,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Opciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    return Column(
      children: [
        RadioListTile(title: Text('Puntos'),value: '1', groupValue: provider.modoPago, onChanged: (value){ provider.modoPago=value;}),
        RadioListTile(title: Text('Efectivo'),value: '2', groupValue: provider.modoPago, onChanged: (value){provider.modoPago=value;}),
        RadioListTile(title: Text('Transferencia Bancaria'),value: '3', groupValue: provider.modoPago, onChanged: (value){provider.modoPago=value;}),
        RadioListTile(title: Text('Tigo Money'),value: '4', groupValue: provider.modoPago, onChanged: (value){provider.modoPago=value;}),
        RadioListTile(title: Text('Pagos Net'),value: '5', groupValue: provider.modoPago, onChanged: (value){provider.modoPago=value;}),
        RadioListTile(title: Text('ATC'),value: '6', groupValue: provider.modoPago, onChanged: (value){provider.modoPago=value;}),
      ],
    );
  }
}

class _ButtonNext extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final colores = ColoresApp();
    return ElevatedButton(
      onPressed: (){}, 
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Siguiente', style: TextStyle(fontSize: 18.0),),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        primary: colores.boton
      ),
    );
  }
}
