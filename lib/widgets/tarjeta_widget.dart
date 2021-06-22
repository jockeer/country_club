import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjetas_credito_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class TarjetaCreditoWidget extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return Container(
      width: phoneSize.width,
      height: phoneSize.height*0.3,
      child: (provider.tarjetas[0]==null)
      ?Center(child: Text('Registre una tarjeta para continuar', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),)
      :
      
      PageView.builder(
        controller: PageController(
          viewportFraction: 0.85
        ),
        physics: BouncingScrollPhysics(),
        itemCount: provider.tarjetas.length,
        itemBuilder: (_, index){
          return _Tarjeta(index: index, tarjeta: provider.tarjetas[index]);
        },
      ),
    );
  }
}

class _Tarjeta extends StatelessWidget {
  final int index;
  final TarjetaCredito tarjeta;
  final colores = ColoresApp();

  _Tarjeta({@required this.index, @required this.tarjeta});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return GestureDetector(
      onTap: (){
        provider.tarjetaSeleccionada = tarjeta.id;
        print('id de la tarjeta: ' + provider.tarjetaSeleccionada.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: (provider.tarjetaSeleccionada == tarjeta.id)
          ?[
            BoxShadow(
              color: Colors.green.withOpacity(0.35),
              spreadRadius: 5,
              blurRadius: 1,
              offset: Offset(0, 0), 
            )
          ]
          :null
        ),
        child: CreditCardWidget(
          cardBgColor: colores.verdeOscuro,
          cardNumber: provider.tarjetas[index].cardNumber, 
          expiryDate: provider.tarjetas[index].expiracyDate, 
          cardHolderName: provider.tarjetas[index].cardHolderName, 
          cvvCode: provider.tarjetas[index].cvv, 
          showBackView: false
        ),
      ),
    );
  }
}