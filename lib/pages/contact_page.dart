import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/services/contact_service.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:country/widgets/success_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {

  final _contactService = ContactService();

  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(titulo: 'Ayuda'),
      body: FutureBuilder(
        future: _contactService.obtenerContacto(),
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.hasData) {
            if (snapshot.data==null) {
              return Center(child: Text('compruebe su conexion a Internet'),);
            }
            return SingleChildScrollView(child: _Contacto(contacto: snapshot.data,formState:formState)); 
          }     
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}

class _Contacto extends StatelessWidget {
  final contacto;
  final GlobalKey<FormState> formState;
  final colores= ColoresApp();
  _Contacto({@required this.contacto, @required this.formState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Contactanos', style: TextStyle(fontSize: 20.0,color: colores.verdeOscuro, fontWeight: FontWeight.w500),),
              IconButton(
                onPressed: (){
                  launch("tel://${this.contacto["phone"]}");
                }, 
                icon: Icon(Icons.phone)
              ),
            ],
          ),
          Divider(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'Contáctanos a través de: '),
                TextSpan(text: this.contacto["email"], style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' o usando el formulario de consultas:'),
              ]
            )
          ),
          Divider(),
          Form(
            key: formState,
            child: _MensajeAyuda()
          ),
          SizedBox(height: 20.0,),
          _ButtonEnviarMensaje(formState: formState,),
          SizedBox(height: 50.0,),
          PieLogoWidget()  
        ],
      ),
    );
  }
}

class _MensajeAyuda extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return TextFormField(
      maxLines: 10,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Escriba su mensaje...',
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
        filled:true,
        fillColor: Colors.white
      ),
      validator: (value){
        if (value.isEmpty) {
          return "Ingrese un mensaje para continuar";
        }
        return null;
      },
      onChanged: (value){
        provider.mensajeAyuda= value;
      },
    );
  }
}

class _ButtonEnviarMensaje extends StatelessWidget {
  final estilos = EstilosApp();
  final GlobalKey<FormState> formState;
  final _contactService = ContactService();
  _ButtonEnviarMensaje({@required this.formState});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return ElevatedButton(
      child: estilos.buttonChild(texto: 'Enviar Mensaje'),
      style: estilos.buttonStyle(),
      onPressed: ()async {
        if (!this.formState.currentState.validate()) return;

        final respuesta = await _contactService.enviarMensaje(provider.mensajeAyuda);
        if (respuesta==0) {
          mostrarSnackBar(context, 'Error con el servidor');
          return;
        } 
        if (respuesta == null) {
          return showDialog(context: context, builder: (context){return NoInternetWidget();});  
        }
        
        showDialog(context: context, builder: (context){return SuccessDialogWidget(mensaje: 'Su mensaje fue enviado correctamete recibira un Email con la respuesta', ruta: 'main_menu',);});

        //print(respuesta);

      },
    );
  }
}