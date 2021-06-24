
import 'dart:math';
import 'package:country/helpers/datos_constantes.dart';
import 'package:country/widgets/sesion_caducada_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/reserva_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'show CalendarCarousel;
import 'package:provider/provider.dart';

class ReservaProcesoPage extends StatefulWidget {

  @override
  _ReservaProcesoPageState createState() => _ReservaProcesoPageState();
}

class _ReservaProcesoPageState extends State<ReservaProcesoPage> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ReservaProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Reservas'),
      body: ModalProgressHUD(
        child: GestureDetector(
          onTap: (){
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: ListView(
            children: [
              SizedBox(height: 20.0,),
              _Categoria(),
              _Calendar(),
              _FormularioReservas(formState: formState)
            ],
          ),
        ),
        inAsyncCall: provider.carga,
      ),
      floatingActionButton: FloatingActionButton(
        child: Transform.rotate(child: Icon(Icons.priority_high_sharp,),angle: pi,),
        backgroundColor: Color(0xff00472B),
        onPressed: (){
          _mostrarAlerta();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void _mostrarAlerta(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ( context ){
        return _DialogInfo();
      }
    );
  }
}

class _Categoria extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[400])
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: DropdownButton(
          underline: Container(
            height: 0.0,
          ),
          
          icon: Icon(Icons.arrow_circle_down_outlined),
          isExpanded: true,
          value: provider.codigoCab,
          items: [
            DropdownMenuItem(child: Text('La Palmera', style: TextStyle(color: Colors.black),), value: '1',),
            DropdownMenuItem(child: Text('Bar Asai', style: TextStyle(color: Colors.black),), value: '2',),
            DropdownMenuItem(child: Text('El Caribeño', style: TextStyle(color: Colors.black),), value: '3',),
            DropdownMenuItem(child: Text('Cabaña Sumuque', style: TextStyle(color: Colors.black),), value: '4',),
            DropdownMenuItem(child: Text('Hoyo 19', style: TextStyle(color: Colors.black),), value: '5',),
          ],
          onChanged: (opt){
            provider.codigoCab=opt;
          },
        ),
      ),
    );
  }
}

class _Calendar extends StatefulWidget {
  @override
  __CalendarState createState() => __CalendarState();
}
class __CalendarState extends State<_Calendar> {
  DateTime _currentDate;
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    DateTime fecha = DateTime(today.year, today.month, today.day);
    return Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
      child: CalendarCarousel(
        todayButtonColor: Colors.transparent,
        todayBorderColor: Colors.green,
        todayTextStyle: TextStyle(color: Colors.black),
        locale: 'es',
        onDayPressed: (DateTime date, List events) {
          // print(DateTime(date.year,date.month,date.day));
          provider.fecha = DateTime(date.year,date.month,date.day).toString(); 
          setState(() {
            _currentDate=DateTime(date.year,date.month,date.day);
          });
        },
        iconColor: Colors.black,
        headerTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        headerTitleTouchable: true,
        weekendTextStyle: TextStyle(
          color: Colors.green,
        ),
        thisMonthDayBorderColor: Colors.transparent,
        minSelectedDate: fecha,

        // weekFormat: false,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true, 
      ),
    );
  }
}


class _FormularioReservas extends StatelessWidget {
  final GlobalKey<FormState> formState;

  final estilos = EstilosApp();
  final prefs = PreferenciasUsuario();
  final reservaService = ReservaService();

  _FormularioReservas({@required this.formState});

  @override 
  Widget build(BuildContext context) {
  final provider = Provider.of<ReservaProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Form(
        key: this.formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('hora de la reserva'),
                      SizedBox(height: 10.0,),
                      _HoraReserva(),
                    ],
                  ),
                ),
                SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Cantidad de personas'),
                      SizedBox(height: 10.0,),
                      _CantidadPersonas(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            estilos.inputLabel(label: 'Celular de Contacto'),
            _CelularContacto(),
            estilos.inputLabel(label: 'Nombre de Contacto'),
            _NombreContacto(),
            estilos.inputLabel(label: 'Requerimientos extras'),
            _RequerimientosExtras(),
            SizedBox(height: 20.0,),
            _ButtonReserva(formState: this.formState,),
         
            SizedBox(height: 20.0,)
          ],
        ),
      ),
    );
  }
}

class _RequerimientosExtras extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<ReservaProvider>(context);

    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      decoration: InputDecoration(
        hintText: 'Requerimientos extras',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        filled:true,
        fillColor: Colors.white
      ),
      onChanged: (value){
        provider.reqExtras = value;
      },
    );
  }
}

class _CantidadPersonas extends StatelessWidget {
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ReservaProvider>(context);

    return TextFormField(
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.phone,
      decoration: estilos.inputDecoration(hintText: '0'),
      onChanged: (value){
        provider.cantPersonas = value;
      },
      validator: (value){
        final formValdidator = FormValidator();
        if ( value.isEmpty ) return 'La cantidad debe ser un numero';
        if (formValdidator.isNumeric(value)) {
          return null;
        } else {
          return 'El valor debe ser un numero';
        }
      },
    );
  }
}

class _HoraReserva extends StatelessWidget {

  final TextEditingController _inputFileTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context,listen: true);
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFileTimeController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintStyle: TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold,),
        hintText: provider.hora,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        filled:true,
        fillColor: Colors.white
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        _selectTime(context, provider);
      },
      validator: (value){
        if(provider.hora == '00:00'){
          return 'La hora debe ser elegida';
        }else{
          return null;
        }
      },
    );
  }
  void _selectTime(BuildContext context, ReservaProvider provider) async {
      
      TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Confirma tu hora',
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      }
    );

    if ( picked != null ) {
      final horas = ((picked.hour.toString().length < 2)  ? '0${picked.hour}' : picked.hour);
      final minutos = ((picked.minute.toString().length < 2)  ? '0${picked.minute}' : picked.minute);
      provider.hora = '$horas:$minutos'; 
      // print(provider.hora);
    }
  }
}

class _DialogInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Container(decoration: BoxDecoration(color: Color(0xff64A640), borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))) ,padding: EdgeInsets.symmetric(vertical: 20.0) , child: Text('Horario de atencion',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),textAlign: TextAlign.center, ),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
            Text('Lunes'),
            Container(decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(20.0)), padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0) ,child: Text('12:30 - 23:00'),)
          ],),
          SizedBox(height: 20.0,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
            Text('Martes a Sabado'),
            Container(decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(20.0)), padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0) ,child: Text('12:30 - 23:00'),)
          ],),
          SizedBox(height: 20.0,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
            Text('Feriados'),
            Container(decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(20.0)), padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0) ,child: Text('12:30 - 23:00'),)
          ],),
        
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            child: Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
            onPressed: (){
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              primary: Color(0xff00472B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
            ),
          ),
        ),
      ],
    );
  }
}

class _CelularContacto extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: estilos.inputDecoration(hintText: 'Celular de contacto'),
      validator: (value){
        if (value.isEmpty) {
          return "Digite un numero de contacto";
        }
        return null;
      },
      onChanged: (value){
        provider.telefono = value;
      },
    );
  }
}

class _NombreContacto extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return TextFormField(
      decoration: estilos.inputDecoration(hintText: 'Nombre de contacto'),
      validator: (value){
        if (value.isEmpty) {
          return "Ingrese un nombre";
        }
        return null;
      },
      onChanged: (value){
        provider.nombre=value;
      },
    );
  }
}

class _DialogExito extends StatelessWidget {
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      titlePadding: EdgeInsets.only(top: 10.0),
      contentPadding: EdgeInsets.zero,
      title: Image(image: AssetImage('assets/icons/logo.png'), height: 80.0,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('¡Muchas Gracias!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
          SizedBox(height: 10.0,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black87,fontSize: 14.0),
              children: [
                TextSpan(text: 'Estimado Asociado su '),
                TextSpan(text: 'Pre-reserva', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' ha sido registrada satisfactoriamente, en breve nos comunicaremos con usted para la confirmación de su datos.'),
              ]

            ),
          ),
          SizedBox(height: 20.0,),
          Image(image: AssetImage('assets/images/notificacion.png'),width: 200,)
        ],
      ),
      actions: [
        Center(
          child:Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('main_menu'));
                // Navigator.popUntil(context, ModalRoute.withName('main_menu'));
              }, 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text('Aceptar', style: TextStyle(fontSize: 18.0),),
              ), 
              style: estilos.buttonStyle()
            )
          )
        )
      ],
    );
  }
}

class _ButtonReserva extends StatelessWidget {

  final GlobalKey<FormState> formState;
  final estilos = EstilosApp();
  final prefs = PreferenciasUsuario();
  final _reservaService = ReservaService();

  _ButtonReserva({@required this.formState});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context, listen: false);
    return Center(
      child: ElevatedButton(
        style: estilos.buttonStyle(),
        child: estilos.buttonChild(texto: 'Realizar Reserva'),
        onPressed: ()async{
          if (provider.fecha.isEmpty) {
            return mostrarSnackBar(context, 'Debe elegir una fecha');
          }
          if(!this.formState.currentState.validate())return;

          provider.carga = true;

          final nuevaReserva = Reserva();
          nuevaReserva.codecli = prefs.codigoSocio;
          nuevaReserva.cabanaid = provider.codigoCab;
          nuevaReserva.fecha = provider.fecha;
          nuevaReserva.hora = provider.hora;
          nuevaReserva.cantidad = provider.cantPersonas;
          nuevaReserva.celular = provider.telefono;
          nuevaReserva.nombre = provider.nombre;
          nuevaReserva.requerimientos = provider.reqExtras;

          final respuesta = await _reservaService.guardarReserva(nuevaReserva);
          provider.carga = false;

          if (respuesta==null) {
            return showDialog(context: context, builder: (context){ return NoInternetWidget(); });
          }
          if (respuesta.containsKey("error")) {
            return showDialog(
              context: context, 
              builder: (context){
                return SessionCaducadaWidget();
              }
            );
          }else{
            return showDialog(
              context: context, 
              builder: (context){
                return _DialogExito();
              }
            );
          } 
        },
      ),
    );
  }
}