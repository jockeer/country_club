import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/credit_card_model.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/services/tarjeta_service.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DetalleRecargaPage extends StatelessWidget {

  final prefs = PreferenciasUsuario();
  final estilos = EstilosApp();
  final _tarjetaService= TarjetaService();
  final formStat = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    final TarjetaCredito tarjeta = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
      },
      child: ModalProgressHUD(

        inAsyncCall: provider.carga,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarWidget(titulo: 'Detalle - Transaccion'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              width: double.infinity,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
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
                  _Detalle(tarjeta: tarjeta,formStat: formStat,),
                 
                  Divider(),
                  //Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: ()async{
                        if (!formStat.currentState.validate()) return;
                        provider.carga=true;
                        if (provider.tipoPago == 3) {
                          _tarjetaService.recargarTarjeta(provider.montoRecarga,provider.codigoTarjeta, tarjeta, provider.glosa);
                          
                        }else if(provider.tipoPago == 1){             
                          final rsp = await _tarjetaService.recargarTarjeta(provider.montoRecarga,prefs.codigoSocio, tarjeta, provider.glosa);
                          provider.carga=false;
                          if (rsp==null) return mostrarSnackBar(context, 'Error al recargar la tarjeta');
                        }
                        else if(provider.tipoPago == 2){
                          _tarjetaService.pagoMensualidad(provider.montoRecarga,prefs.codigoSocio, tarjeta, provider.glosa);
                        }
                        
                      }, 
                      child: estilos.buttonChild(texto: 'Realizar Recarga'),
                      style: estilos.buttonStyle(),
                  ),
                  
                  PieLogoWidget()             
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Detalle extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  final TarjetaCredito tarjeta;
  final estilos = EstilosApp();

  final formStat;

  _Detalle({@required this.tarjeta, @required this.formStat});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black12,
            width: double.infinity,
            child:(provider.tipoPago==1)
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recarga de Tarjeta de Socio',style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
            )
            : (provider.tipoPago==3)
            ?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recarga de Tarjeta de Dependiente',style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
            )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pago de Membresia',style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
            )
            
          ),
          Divider(),
          _Info(titulo: 'Código del socio: ', texto: prefs.codigoSocio),
          
          (provider.tipoPago == 3)
          ?_Info(titulo: 'Código del dependiente: ', texto: provider.codigoTarjeta) 
          :Container(),

          _Info(titulo: 'Titular: ', texto: prefs.nombreSocio),
          
          (provider.tipoPago == 3)
          ? _Info(titulo: 'Dependiente: ', texto: provider.dependiente)
          :Container(),
          _Info(titulo: 'Monto: ', texto: provider.montoRecarga + ' Bs.'), 
          _Info(titulo: 'Número de Tarjeta: ', texto: '**** **** **** '+tarjeta.cardNumber.substring(tarjeta.cardNumber.length-4)),

          Container(
            child: (provider.tipoPago==2)
            ?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Info(titulo: 'Codigo de Deuda: ', texto: provider.deuda.idDeuda.toString()),
                _Info(titulo: 'Detalle: ', texto: provider.deuda.detalle),
                _Info(titulo: 'Tipo: ', texto: provider.deuda.tipo),
                _Info(titulo: 'Fecha: ', texto: provider.deuda.fecha.substring(0,10))
              ],
            )
            :Container(),
          ),
          SizedBox(height: 20,),
          Form(
            key: this.formStat,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration:InputDecoration(
                    hintText: 'Glosa',
                    prefixIcon: Icon(Icons.book)
                  ),
                  onChanged: (value){
                    provider.glosa = value;
                  },
                  validator: (value){
                    if (value.isEmpty) return "La glosa es necesaria";
                    return null;
                  }
                  // decoration: estilos.inputDecoration(hintText: 'Glosa',padingTop: 15.0),

                )

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {

  final String titulo;
  final String texto;

  _Info({@required this.titulo, @required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(text: this.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: this.texto)
          ]
        ),
      ),
    );
  }
}