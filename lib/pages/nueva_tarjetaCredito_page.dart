import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjetas_credito_provider.dart';
import 'package:country/services/database_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:provider/provider.dart';

class NuevaTarjetaCreditoPage extends StatefulWidget {
  
  @override
  _NuevaTarjetaCreditoPageState createState() => _NuevaTarjetaCreditoPageState();
}

class _NuevaTarjetaCreditoPageState extends State<NuevaTarjetaCreditoPage> {
  final formkey = GlobalKey<FormState>();
  final estilos = EstilosApp();
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return Scaffold(
      appBar: appBarWidget(titulo: 'Nueva Tarjeta'),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          GestureDetector(
            onTap: (){
              provider.showBackView = !provider.showBackView;
            },
            child: CreditCardWidget(
              cardBgColor: colores.verdeOscuro,
              cardNumber: provider.cardNumber, 
              expiryDate: provider.expiryDate, 
              cardHolderName: provider.cardHolderName, 
              cvvCode: provider.cvvCode, 
              showBackView: provider.showBackView
            ),
          ),
          CreditCardForm(
            cardNumber: provider.cardNumber, 
            expiryDate: provider.expiryDate, 
            cardHolderName: provider.cardHolderName, 
            cvvCode: provider.cvvCode,
            themeColor: colores.gris, 
            onCreditCardModelChange: (value){
              
              provider.brand = value.brand;
              provider.cardNumber = value.cardNumber;
              provider.expiryDate = value.expiryDate;
              provider.cardHolderName = value.cardHolderName;
              provider.cvvCode = value.cvvCode;
            },
            
             
            formKey: formkey,
            obscureCvv: true,
          ),
          ElevatedButton(
            child: estilos.buttonChild(texto: 'Registrar'),
            style: estilos.buttonStyle(),
            onPressed: ()async{
                if (!formkey.currentState.validate()) return;
              TarjetaCredito tarjeta = TarjetaCredito(
                cardHolderName: provider.cardHolderName,
                cardNumber: provider.cardNumber,
                brand: provider.brand,
                cvv: provider.cvvCode,
                expiracyDate: provider.expiryDate,
                cardNumberHidden: '00000'
              );
              final respuesta = await DBService.db.nuevaTarjeta(tarjeta);
              if (respuesta!=null) {
                Navigator.pop(context);
              }
            },
          )
          
        ],
      ),
    );
  }
}