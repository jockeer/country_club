import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/reserva_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/success_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservaWidget extends StatelessWidget {

  final List<Reserva> reservas;


  ReservaWidget({@required this.reservas});
  

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final provider =Provider.of<ReservaProvider>(context);
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 4.0,
                offset: Offset(0.0, 5.0), // changes position of shadow
              ),
            ]
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.only(right: 20.0),
          width: phoneSize.width,
          child: Row(
            children: [
              Container(color: Colors.white,width: phoneSize.width*0.15,height: phoneSize.height*0.23,
                child: FadeInImage(
                  placeholder: AssetImage('assets/icons/logo.png'),
                  image: AssetImage('assets/images/${(reservas[index].cabanaid == '1' )?'La_palmera':(reservas[index].cabanaid == '2' ) ?'Bar_Asai' :(reservas[index].cabanaid == '3' )?'El_Caribeño':(reservas[index].cabanaid == '4' )?'Cabaña_Sumuque':(reservas[index].cabanaid == '5' )?'Hoyo_19':null}.png'), fit: BoxFit.cover,)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reservas[index].nombreCab, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                              Text(
                                reservas[index].estado, 
                                style: TextStyle(
                                  fontSize: 14.0 ,
                                  color: (reservas[index].status == "2") ? Colors.green : (reservas[index].status =="1")?Colors.orange: ((reservas[index].status =="3"))?Colors.red: Colors.black54,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Text('Cantidad: ${reservas[index].cantidad} personas'),
                              SizedBox(height: 5.0,),
                              Text('${reservas[index].fecha.substring(0,10)} , ${reservas[index].hora}'),
                              SizedBox(height: 10.0,),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      // Expanded(child: Container(),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: (reservas[index].status == "2" || reservas[index].status == "1")
                        ? ([
                            ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Reprogramar'),
                              onPressed: (){
                                provider.hora=reservas[index].hora;
                                provider.fecha = reservas[index].fecha;
                                provider.cantPersonas = reservas[index].cantidad;
                                provider.codigoCab=reservas[index].cabanaid;
                                provider.telefono= reservas[index].celular;
                                provider.nombre=reservas[index].nombre;
                                provider.reqExtras=reservas[index].requerimientos;
                                Navigator.pop(context);
                                Navigator.pushNamed(context, 'reserva_repro', arguments: reservas[index]);
                              },
                            ),
                            SizedBox(width: 20.0,),
                            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))) ,child: Text('Cancelar'),
                              onPressed: ()async {
                                final conexion = await comprobarInternet();
                                if (!conexion) {
                                  return showDialog(context: context, builder: (context){return NoInternetWidget();});
                                }
                                showDialog(context: context, builder: (context){return _Confirmar(cabana: reservas[index].nombreCab, idReserva: reservas[index].id,);});
                                
                              }, 
                            ),
                          ])
                        : [
                            ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Visualizar'),
                              onPressed: (){
                               Navigator.pushNamed(context, 'reserva_repro', arguments: reservas[index]);
                              },
                            ),
                          ]    
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _Confirmar extends StatelessWidget {
  final String cabana;
  final String idReserva;
  final _reservaService = ReservaService();

  final colores = ColoresApp();

  _Confirmar({@required this.cabana, @required this.idReserva});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reserva - ' + this.cabana),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Esta seguro que desea anular su reserva?'),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('No, Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red
              ),
            ),
            ElevatedButton(
              child: Text('Si, Estoy seguro', style: TextStyle(color: Colors.black54),),
              onPressed: ()async{
                await _reservaService.cancelarReserva(this.idReserva);
                showDialog(context: context, builder: (context){
                  return SuccessDialogWidget(mensaje: 'Su reserva fue anulada correctamente', ruta: 'main_menu',);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0.0
              ),
            ),
          ],
    );
  }
}