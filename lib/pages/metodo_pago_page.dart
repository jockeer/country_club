import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        RadioListTile(title: Text('Puntos'),value: '1', groupValue: '1', onChanged: (value){}),
        RadioListTile(title: Text('Efectivo'),value: '1', groupValue: '2', onChanged: (value){}),
        RadioListTile(title: Text('Transferencia Bancaria'),value: '1', groupValue: '3', onChanged: (value){}),
        RadioListTile(title: Text('Tigo Money'),value: '1', groupValue: '4', onChanged: (value){}),
        RadioListTile(title: Text('Pagos Net'),value: '1', groupValue: '5', onChanged: (value){}),
        RadioListTile(title: Text('ATC'),value: '1', groupValue: '5', onChanged: (value){}),
      ],
    );
  }
}