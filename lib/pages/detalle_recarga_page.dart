import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleRecargaPage extends StatelessWidget {

  final prefs = PreferenciasUsuario();
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    final TarjetaCredito tarjeta = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Detalle - Recarga'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('¡Ultimo Paso!', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              ),
            ),
            Divider(),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Codigo del Socio: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: prefs.codigoSocio, style: TextStyle(fontSize: 18))
                    ]
                  ),
                ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Monto de la recarga: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: provider.montoRecarga + ' Bs.')
                    ]
                  ),
                ),
           ),
            
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Titular: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: tarjeta.cardHolderName)
                    ]
                  ),
                ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Numero Tarjeta: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '**** **** **** '+tarjeta.cardNumber.substring(tarjeta.cardNumber.length-4))
                    ]
                  ),
              ),
            ),
            Divider(),
            Expanded(child: Container()),
            Center(
              child: ElevatedButton(
                onPressed: (){}, 
                child: estilos.buttonChild(texto: 'Realizar Recarga'),
                style: estilos.buttonStyle(),
              ),
            ),
            Expanded(child: Container()),
            Image(image: AssetImage('assets/icons/logo.png'))
            
          ],
        ),
      ),
    );
  }
}