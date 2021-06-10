import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/widgets/no_internet_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservaReproPage extends StatefulWidget {
  
  @override
  _ReservaReproPageState createState() => _ReservaReproPageState();
}

class _ReservaReproPageState extends State<ReservaReproPage> {
  @override
  Widget build(BuildContext context) {

    final Reserva reserva = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar( reserva ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _formulario(reserva),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _formulario(Reserva reserva){
    return (reserva.status=='1')?_Formulario(reserva: reserva,):_Datos(reserva: reserva,);
  }

  Widget _crearAppBar(Reserva reserva) {
    final colores = ColoresApp();
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: colores.verdeOscuro,
      expandedHeight: 200.0,
      brightness: Brightness.dark, 
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          reserva.nombreCab,
          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        background: FadeInImage(
          image: AssetImage('assets/images/${(reserva.cabanaid == '1' )?'La_palmera':(reserva.cabanaid == '2' ) ?'Bar_Asai' :(reserva.cabanaid == '3' )?'El_Caribeño':(reserva.cabanaid == '4' )?'Cabaña_Sumuque':(reserva.cabanaid == '5' )?'Hoyo_19':null}.png',),
          placeholder: AssetImage('assets/icons/logo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {

  final Reserva reserva;
  final prefs = PreferenciasUsuario();

  final estilos = EstilosApp();
  final colores = ColoresApp();

  _Formulario({@required this.reserva});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modificacion de la reserva - ' + this.reserva.nombreCab, style: TextStyle(fontSize: 20.0, color: colores.verdeOscuro, fontWeight: FontWeight.bold ),),
            Divider(),
            estilos.inputLabel(label: 'Fecha de la reserva'),
            _Fecha(),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      estilos.inputLabel(label: 'Hora de la reserva'),
                      _HoraReserva()
                    ],
                  ),
                ),
                SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      estilos.inputLabel(label: 'Cantidad de personas'),
                      _CantidadPersonas()
                    ],
                  ),
                ),
              ],
            ),
            estilos.inputLabel(label: 'Celular de contacto'),
            TextFormField(
              initialValue: this.reserva.celular,
              decoration: estilos.inputDecoration(hintText: "Celular de contacto"),
            ),
            estilos.inputLabel(label: 'Nombre de contacto'),
            TextFormField(
              initialValue: this.reserva.nombre,
              decoration: estilos.inputDecoration(hintText: "Nombre de contacto"),
            ),
            estilos.inputLabel(label: 'Requerimientos extras'),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              initialValue: this.reserva.requerimientos,
              decoration: estilos.inputDecoration(hintText: "Requerimientos extras", padingTop: 15.0),
            ),
            Divider(),
            Center(
              child: ElevatedButton(
                onPressed: ()async {
                  final conexion = await comprobarInternet();
                  if (!conexion) {
                    return showDialog(context: context, builder: (context){return NoInternetWidget();});
                  }
                  final reserva = Reserva();
                  reserva.codecli=prefs.codigoSocio;
                  reserva.cabanaid = provider.codigoCab;
                  reserva.fecha= provider.fecha;
                  reserva.hora=provider.hora;
                  reserva.cantidad=provider.cantPersonas;
                  reserva.celular=provider.telefono;
                  reserva.nombre = provider.nombre;
                  reserva.requerimientos = provider.reqExtras;

                  //final respuesta = await reservaService.guardarReserva(reserva);
                }, 
                child: Padding(padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),child: Text('Guardar Cambios'),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HoraReserva extends StatelessWidget {

  final _inputFileTimeController = TextEditingController();
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
        _selectTime(context);
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

  void _selectTime(BuildContext context) async {
      final provider = Provider.of<ReservaProvider>(context,listen: false);

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
    }
  }
}

class _CantidadPersonas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ReservaProvider>(context);

    return TextFormField(
      // initialValue: '0',
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.phone,
      initialValue: provider.cantPersonas,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintStyle: TextStyle(fontSize: 30.0),
        hintText: '0',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        filled:true,
        fillColor: Colors.white
      ),
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

class _Fecha extends StatelessWidget {

  final _inputFiledDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFiledDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: provider.fecha.substring(0,10),
        hintStyle: TextStyle(color: Colors.black),
        suffixIcon: Icon(Icons.calendar_today),
      ), 
      onTap: (){

        FocusScope.of(context).requestFocus(new FocusNode()); // quita el focus del elemento
        _selectDate( context );

      },
      
    );
  }
  void _selectDate(BuildContext context) async {
    final provider = Provider.of<ReservaProvider>(context, listen: false);
    DateTime fecha = DateTime.now();

    DateTime picked = await showDatePicker(
      context: context,
      helpText: 'Confirma tu fecha',
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(fecha.year+2),
    );
    if ( picked != null ) {
      provider.fecha = picked.toString();
    }

  }
}

class _Datos extends StatelessWidget {
  final Reserva reserva;
  final colores = ColoresApp();
  _Datos({@required this.reserva});

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Cabaña',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.nombreCab),
            leading: Icon(Icons.home_outlined, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Estado',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.estado, style: TextStyle(color: (reserva.status == "2") ? Colors.green : (reserva.status =="1")?Colors.orange: ((reserva.status =="3"))?Colors.red: Colors.black54, fontWeight: FontWeight.bold),),
            leading: Icon(Icons.info_outline, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Cantidad',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.cantidad+ ' personas'),
            leading: Icon(Icons.data_saver_off_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Celular de referencia',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.celular),
            leading: Icon(Icons.phone_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Nombre de referencia',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.nombre),
            leading: Icon(Icons.person, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Fecha',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.fecha.substring(0,10)),
            leading: Icon(Icons.date_range_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Hora',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            trailing: Text(this.reserva.hora),
            leading: Icon(Icons.av_timer_outlined, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Requerimientos',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.requerimientos),
            leading: Icon(Icons.notes, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Notas',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text('Estas notas seran cuando haya un motivo del rechazo de la reserva o alguna nota de parte del Country Club'),
            leading: Icon(Icons.note_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          SizedBox(height: 20.0,),
          Center(child: Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.55,)),
          SizedBox(height: 20.0,),

        ],
      ),
    );
  }
}