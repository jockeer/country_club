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
    final phoneSize = MediaQuery.of(context).size;
    final TarjetaCredito tarjeta = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Detalle - Transaccion'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              _Detalle(tarjeta: tarjeta,),
             
              Divider(),
              Expanded(child: Container()),
              ElevatedButton(
                  onPressed: (){}, 
                  child: estilos.buttonChild(texto: 'Realizar Recarga'),
                  style: estilos.buttonStyle(),
              ),
              
              Expanded(child: Container()),
              Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.6,)
              
            ],
          ),
        ),
      ),
    );
  }
}

class _Detalle extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  final TarjetaCredito tarjeta;

  _Detalle({@required this.tarjeta});
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
              child: Text('Recarga de Tarjeta de Socio',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pago de Membresia',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            )
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
                  TextSpan(text: 'Monto: ', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Container(
            child: (provider.tipoPago==2)
            ?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Codigo de Deuda: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: provider.deuda.idDeuda.toString())
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
                          TextSpan(text: 'Detalle: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: provider.deuda.detalle)
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
                          TextSpan(text: 'Tipo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: provider.deuda.tipo)
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
                          TextSpan(text: 'Fecha: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: provider.deuda.fecha.substring(0,10))
                        ]
                      ),
                  ),
                ),
              ],
            )
            :null
            ,
          )
        ],
      ),
    );
  }
}