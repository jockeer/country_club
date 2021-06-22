import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/notificacion_provider.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  final estilos =EstilosApp();
  final colores =ColoresApp();
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<NotificacionesProvider>(context);
    provider.cargarNotificaciones();
    return Scaffold(
      appBar: appBarWidget(titulo: 'Inbox'),
      drawer: MenuLateralWidget(),
      // backgroundColor:Colors.white,
      body: Column(
        children: [
          Expanded(
            child: (provider.mensajes.length==0)
            ? Center(child: Text('No tiene mensajes'),)
            : ListView.builder(
              itemCount: provider.mensajes.length,
              itemBuilder: (_,index){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 7.0),
                      )
                    ]
                  ),
                  child: Card(
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.mensajes[index].titulo, style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10.0,),
                          Text(provider.mensajes[index].fecha, style: TextStyle(color: Colors.black54),),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('Ver mensaje'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: colores.verdeOscuro,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
                                ),
                                onPressed: (){

                                }, 
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ),
          PieLogoWidget()
        ],
      ),
    );
  }
}