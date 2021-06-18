import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjetas_credito_provider.dart';
import 'package:country/services/database_service.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/floating_button_widget.dart';
import 'package:country/widgets/tarjeta_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/tarjeta_provider.dart';


class RecargaTarjetaPage extends StatelessWidget {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final colores = ColoresApp();

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final provider = Provider.of<TarjetaProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Tarjeta(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
                child: Text("Monto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              ),
              Container(
                child: (provider.tipoPago==1)
                ? Column(
                  children: [
                    _MontosFijos(),
                    SizedBox(height: 30.0,),
                    _OtroMonto(),

                  ],
                ) 
                : Text(provider.montoRecarga + ' Bs.', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
              ),
              
              
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: (){
                  Provider.of<TarjetasCreditoProvider>(context,listen: false).tarjetaSeleccionada=0;
                  Navigator.pushNamed(context, 'administrar_tarjetas');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Administrar Tarjetas',style: TextStyle(fontWeight: FontWeight.w600),),
                    Icon(Icons.credit_card, color: colores.verdeOscuro),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              FutureBuilder(
                future: DBService.db.getAllTarjetasPrueba(context),
                builder: (_,AsyncSnapshot<List<TarjetaCredito>> snapshot){
                  if (snapshot.hasData) {
                    if (snapshot.data[0] == null) {
                      return Center(child: Text('No tiene tarjetas registradas'),);
                    } 
                    return TarjetaCreditoWidget();
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              // TarjetaCreditoWidget(),
              SizedBox(height: 30.0,),
              Text('Seleccione una tarjeta para continuar'),
              SizedBox(height: 10.0,),
              _CorreoBoton(),
              SizedBox(height: 30.0,),
              Center(child: Image(image: AssetImage('assets/icons/logo.png'),width: phoneSize.width*0.6, ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(color: Colors.white,),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _OtroMonto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    final phoneSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
            decoration: BoxDecoration(
              color: Color(0xffEBEBEB),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),bottomLeft: Radius.circular(5.0))
            ),
            child: Text('Bs', style: TextStyle(fontSize: 16.0 )),
          ),
          SizedBox(
            width: phoneSize.width*0.3,
            child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Otro monto',
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)), borderSide: BorderSide(color: Colors.black26)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)) ),
                  filled: true,
                  fillColor: Colors.white
                ),

                onTap: (){
                  provider.montoRecarga='00.00';
                  provider.optRecarga=0;
                },
                onChanged: (value){
                  provider.montoRecarga=value;
                },
                
              ),
            )
        ],
      ),
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
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Tarjeta_consumo.png'),fit: BoxFit.fill)),
      ),
    );
  }
}

class _MontosFijos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20.0,),
          _MontoButon(monto: '10',opt: 1,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '20',opt: 2,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '30',opt: 3,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '50',opt: 4,),

          SizedBox(width: 20.0,),
        ],
      );
  }
}

class _MontoButon extends StatelessWidget {

  final String monto;
  final int opt;

  const _MontoButon({@required this.monto, @required this.opt});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TarjetaProvider>(context);
    return TextButton(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
        child: Text('Bs ${this.monto}.00', style: TextStyle(fontSize: 14.0,),),
      ),
      onPressed: (){
        provider.optRecarga = this.opt;
        provider.montoRecarga = '${this.monto}.00';
      },
      style: TextButton.styleFrom(
        padding:EdgeInsets.zero,
        primary: (provider.optRecarga == this.opt)?Colors.white:Colors.black,
        backgroundColor: (provider.optRecarga == this.opt)?Color(0xff00472B):Color(0xffEBEBEB)
      ),
    );
  }
}

class _CorreoBoton extends StatelessWidget {
  final estilos = EstilosApp();
  final formValidator = FormValidator();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetasCreditoProvider>(context);
    final providerB = Provider.of<TarjetaProvider>(context);
    return ElevatedButton(
      onPressed:(provider.tarjetaSeleccionada==0)
      ?null 
      : () async {
        if (provider.tarjetaSeleccionada == 0) return mostrarSnackBar(context, 'Seleccione una tarjeta para continuar');
          //await DBService.db.deleteAll();
        if (providerB.montoRecarga.isEmpty||providerB.montoRecarga=='00.00') return mostrarSnackBar(context, 'Seleccione o ingrese un monto');
      
        if (!formValidator.isNumeric(providerB.montoRecarga)) return mostrarSnackBar(context, 'Ingrese un monto valido');

        // await DBService.db.deleteAll();
        // provider.tarjetaSeleccionada=0;
        final tarjeta = provider.tarjetas.where((element){
          return provider.tarjetaSeleccionada == element.id;
        });
        print(tarjeta);
        print('tarjeta seleccionada :' + tarjeta.first.id.toString());
        
        Navigator.pushNamed(context, 'detalle_recarga',arguments: tarjeta.first);

      }, 
      child: estilos.buttonChild(texto: 'Siguiente'),
      style: estilos.buttonStyle(),
    );
  }
}