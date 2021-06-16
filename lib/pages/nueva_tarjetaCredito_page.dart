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

    return Scaffold(
      appBar: appBarWidget(titulo: 'Nueva Tarjeta'),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: ListView(
          children: [
            _Tarjeta(),
            _Formulario(formkey: formkey),
            _BotonAgregarTareta(formkey: formkey,)
      
          ],
        ),
      ),
    );
  }
}
class _Tarjeta extends StatelessWidget {
  
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return GestureDetector(
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
    );
  }
}

class _Formulario extends StatelessWidget {

  final GlobalKey<FormState> formkey;
  final estilos = EstilosApp();

  _Formulario({@required this.formkey});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CreditCardForm(
        cardNumber: provider.cardNumber, 
        expiryDate: provider.expiryDate, 
        cardHolderName: provider.cardHolderName, 
        cvvCode: provider.cvvCode,
        themeColor: Colors.green, 
        onCreditCardModelChange: (value){
          provider.brand = value.brand;
          provider.cardNumber = value.cardNumber;
          provider.expiryDate = value.expiryDate;
          provider.cardHolderName = value.cardHolderName;
          provider.cvvCode = value.cvvCode;
        },
        
        formKey: formkey,
        obscureCvv: true,
        cvvValidationMessage: 'Ingrese un CVV Valido',
        dateValidationMessage: 'Ingrese una fecha Valida',
        numberValidationMessage: 'Ingrese un numero Valido',
        cvvCodeDecoration: estilos.inputTarjetaDecoration(hintText: 'XXX',labelText: 'CVV'),
        cardNumberDecoration: estilos.inputTarjetaDecoration(hintText: 'XXXX XXXX XXXX XXXX',labelText: 'Numero de tarjeta'),
        cardHolderDecoration: estilos.inputTarjetaDecoration(hintText: 'Nombre',labelText: 'Nombre de la tarjeta'),
        expiryDateDecoration: estilos.inputTarjetaDecoration(hintText: 'MM/YY', labelText: 'MM/YY'),
      ),
    );
  }
}

class _BotonAgregarTareta extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final estilos = EstilosApp();
  _BotonAgregarTareta({@required this.formkey});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              Navigator.pushNamed(context, 'tarjeta_recarga');
            }
          },
        ),
      ],
    );
  }
}