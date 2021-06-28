import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/services/token_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/floating_button_widget.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/success_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RecuperarPassPage extends StatelessWidget {

  final formstate = GlobalKey<FormState>();
  final estilos = EstilosApp();
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context,listen: true);
    final phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        child: SafeArea(
          child: Stack(
            children: [
              _FondoPantalla(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: phoneSize.height*.2,),
                    Text("CONTRASEÑA OLVIDADA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: phoneSize.width*0.05),),
                    SizedBox(height: 50.0,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 50.0), child: estilos.inputLabel(label: 'Correo electrónico',obligatorio: true)),
                    Form( key: formstate ,child: _Formulario()),
                    SizedBox(height: 50.0,),
                    _ButtonRecoverPass(keyForm: formstate, contexto: context,),
                    SizedBox(height: 50.0,),
                    Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.5,),
                    SizedBox(height: 20.0,),
                    
                  ],
                ),
              )
            ],
          ),
        ),
        inAsyncCall: provider.carga,
      ),
      
      floatingActionButton: FloatingButtonWidget(color: Colors.black,),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _FondoPantalla extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/backgrounds/fondo_blanco.png'),
      height: phoneSize.height,
      width: phoneSize.width,
      fit: BoxFit.fill,
    );
  }
}

class _Formulario extends StatefulWidget {

  @override
  __FormularioState createState() => __FormularioState();
}

class __FormularioState extends State<_Formulario> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
          prefixIcon: Icon(Icons.email),
          hintText: "Ingrese su email",
          filled: true,
        
          fillColor: Colors.white
        ),
        validator: (value){
          final formValidator = FormValidator();
          if (value.isEmpty) {
            return "Ingrese un email";
            
          }
          if (formValidator.validarEmail(value)) {
              return null;
          } else {
              return "Ingrese un email valido";
          }
        },
        onChanged: (value){
          provider.email = value;
        },
      ),
      
    );
  }
}

class _ButtonRecoverPass extends StatelessWidget {

  final GlobalKey<FormState> keyForm;
  final BuildContext contexto;
  final estilos = EstilosApp();

  _ButtonRecoverPass({@required this.keyForm, @required this.contexto});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        _submit(context);
      },
      child: estilos.buttonChild(texto: 'Enviar'),
      style: estilos.buttonStyle(),
    );
  }

  void _submit(BuildContext context) async {
    final socioService = SocioService();
      final provider = Provider.of<RegistroProvider>(context, listen: false);
      if (!this.keyForm.currentState.validate() ) return; 
      provider.carga=true;  
      final conexion = await comprobarInternet();
      if (!conexion) {
        showDialog(context: contexto, builder: (context){ return NoInternetWidget();});
        provider.carga=false;
        return;
      }
      final tokenService = TokenService();
      await tokenService.obtenerToken();
      final respuesta = await socioService.recoverPassword(provider.email);
      provider.carga=false;
      if (respuesta == null) {
        return mostrarSnackBar(contexto, 'Error con el servidor');
      }
      if (respuesta["Status"]==false) {
        return mostrarSnackBar(contexto, respuesta["Message"]);
        
      }
      else{
        provider.carga=false;
        showDialog(context: contexto, builder: (context){return  SuccessDialogWidget(mensaje: 'Revise su correo electrónico', ruta: 'login',);});
      
      }
  }
}