import 'package:country/helpers/datos_constantes.dart';
import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/models/reserva_model.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/reserva_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:country/widgets/success_dialog_widget.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ReservaReproPage extends StatefulWidget {
  
  @override
  _ReservaReproPageState createState() => _ReservaReproPageState();
}

class _ReservaReproPageState extends State<ReservaReproPage> {
  final reservaFormState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);

    final Reserva reserva = ModalRoute.of(context).settings.arguments;

    return ModalProgressHUD(
      inAsyncCall: provider.carga,
      child: GestureDetector(
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
        },
        child: Scaffold(
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
          ),
      ),
    );
  }

  Widget _formulario(Reserva reserva){
    return (reserva.status=='1')?_Formulario(reserva: reserva, reservaFormState:reservaFormState):_Datos(reserva: reserva,);
    // return (reserva.status=='1')?_Formulario(reserva: reserva, reservaFormState:reservaFormState):Container();
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
          image: AssetImage('assets/images/${reserva.foto}'),
          placeholder: AssetImage('assets/icons/logo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {


  final Reserva reserva;
  final estilos = EstilosApp();
  final colores = ColoresApp();
  final GlobalKey<FormState> reservaFormState;  

  _Formulario({@required this.reserva, @required this.reservaFormState});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.reservaFormState,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modificacion de la reserva - '+ this.reserva.nombreCab, style: TextStyle(color: colores.verdeOscuro, fontSize: 20.0, fontWeight: FontWeight.w500), ),
            Divider(),
            estilos.inputLabel(label: 'Fecha de la reserva'),
            _Fecha(),
            Row(
              children: [               
                _HoraReserva(),
                SizedBox(width: 20.0,),
                _CantidadPersonas(),  
              ],
            ),
            estilos.inputLabel(label: 'Nombre de Contacto'),
            _NombreContacto(),
            estilos.inputLabel(label: "Teléfono de contacto"),
            _CelularContacto(),
            estilos.inputLabel(label: 'Requerimientos extras'),
            _Requerimientos(),
            Divider(),
            Center(child: _ButtonGuardarCambios(reservaFormState: reservaFormState, reservaId: this.reserva.id)),
            SizedBox(height: 10.0,),
            Center(child: PieLogoWidget())
          ],
        ),
      ),
    );
  }
}

class _NombreContacto extends StatelessWidget {

  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<ReservaProvider>(context);
    return TextFormField(
      initialValue: provider.nombre,
      decoration: estilos.inputDecoration(hintText: 'Nombre de contacto'),
      onChanged: (value)=> provider.nombre = value,
      validator: (value){
        if (value.isEmpty) return "El nombre no puede estar vacio";
        return null;
      },
    );
  }
}

class _CelularContacto extends StatelessWidget {

  final estilos = EstilosApp();
  final validar = FormValidator(); 
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<ReservaProvider>(context);
    return TextFormField(
      initialValue: provider.telefono,
      decoration: estilos.inputDecoration(hintText: 'Telefono de contacto'),
      onChanged: (value)=> provider.telefono = value,
      validator: (value){
        if (value.isEmpty) return "El nombre no puede estar vacio";
        if(!validar.isNumeric(value)) return "El numero de telefono no puede tener letras u otros caracteres especiales";
        return null; 
      },
    );
  }
}
class _Requerimientos extends StatelessWidget {

  final estilos = EstilosApp();
  final validar = FormValidator(); 
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<ReservaProvider>(context);
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      initialValue: provider.reqExtras,
      decoration: InputDecoration(
        hintText: 'Requerimientos extras',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        filled:true,
        fillColor: Colors.white
      ),
      onChanged: (value)=> provider.reqExtras = value,
    );
  }
}

class _ButtonGuardarCambios extends StatelessWidget {
  final GlobalKey<FormState>reservaFormState;
  final String reservaId;
  final colores = ColoresApp();
  final prefs = PreferenciasUsuario();
  final _reservaService = ReservaService();

  _ButtonGuardarCambios({ @required this.reservaFormState, @required this.reservaId });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    return ElevatedButton(
      child: Text('Actualizar Reserva'),
      style: ElevatedButton.styleFrom(
        primary: colores.boton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
      ),
      onPressed: () async {
        if(!this.reservaFormState.currentState.validate()) return;
        provider.carga = true;
        final conexion = await comprobarInternet();
        if (!conexion) {
          provider.carga = false;
          return showDialog(context: context, builder: (context){return NoInternetWidget();});
        }
        final reserva = Reserva();
        reserva.id=this.reservaId;
        reserva.codecli=prefs.codigoSocio;
        reserva.cabanaid = provider.codigoCab;
        reserva.fecha= provider.fecha;
        reserva.hora=provider.hora;
        reserva.cantidad=provider.cantPersonas;
        reserva.celular=provider.telefono;
        reserva.nombre = provider.nombre;
        reserva.requerimientos = provider.reqExtras;
        final respuesta = await _reservaService.actualizarReserva(reserva);
        provider.carga = false;
        if (respuesta) {
          showDialog(context: context, builder: (context){return SuccessDialogWidget(mensaje: 'Su reserva fue actualizada correctamente', ruta: 'main_menu',);});
        } else {
          mostrarSnackBar(context, 'error al actualizar su reserva ');
        }
      },
    );
  }
}

class _HoraReserva extends StatelessWidget {

  final _inputFileTimeController = TextEditingController();
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context,listen: true);
    return Expanded(
      child: Column(
        children: [
          estilos.inputLabel(label: 'Hora'),
          TextFormField(
    
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
          ),
        ],
      ),
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
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ReservaProvider>(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          estilos.inputLabel(label: 'Cantidad'),
          TextFormField(
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
          ),
        ],
      ),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Cabaña',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.nombreCab),
            leading: Icon(Icons.home_outlined, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Estado',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.estado, style: TextStyle(color: (reserva.status == "2") ? Colors.green : (reserva.status =="1")?Colors.orange: ((reserva.status =="3"))?Colors.red: Colors.black54, fontWeight: FontWeight.bold),),
            leading: Icon(Icons.info_outline, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Cantidad',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.cantidad+ ' personas'),
            leading: Icon(Icons.data_saver_off_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Celular de referencia',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.celular),
            leading: Icon(Icons.phone_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Nombre de referencia',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.nombre, overflow: TextOverflow.ellipsis,),
            leading: Icon(Icons.person, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Fecha',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.fecha.substring(0,10)),
            leading: Icon(Icons.date_range_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Hora',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text(this.reserva.hora),
            leading: Icon(Icons.av_timer_outlined, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Requerimientos',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text((this.reserva.requerimientos.isEmpty)?'No tiene requerimientos':this.reserva.requerimientos),
            leading: Icon(Icons.notes, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          ListTile(
            title: Text('Notas',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            subtitle: Text((this.reserva.obs == null) ? 'Sin notas':this.reserva.obs),
            leading: Icon(Icons.note_sharp, color: colores.verdeOscuro,),
            tileColor: Colors.white,
          ),
          SizedBox(height: 20.0,),
          Center(child: Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.55,)),
          SizedBox(height: 20.0,),

        ],
      );
  }
}