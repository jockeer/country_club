import 'package:country/utils/form_validator.dart';
import 'package:flutter/material.dart';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/providers/socio_provider.dart';
import 'package:country/utils/show_snack_bar.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  bool indicator = false;
  final _socioProvider = new SocioProvider();

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ModalProgressHUD(
        child: SafeArea(
          child: Stack(
            children: [
              _FondoPantalla(), //FONDO DE PANTALLA DEL LOGIN
              SingleChildScrollView( //FORMULARIO DE LA APP JUNTO CON LA IMAGEN DE FONDO
                child: Column(
                  children: [
                    // Image(image: AssetImage('')),
                    SizedBox(height: 80.0,),
                    Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.85,),
                    _formulario(),
                  ],
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: indicator,
        // dismissible: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Icon(Icons.arrow_back,color: Colors.black, ),
        onPressed: (){
          Navigator.pushNamed(context,'welcome');
        },
      ), //WIDGET CREADO PARA EL BOTON QUE REGRESA
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _formulario(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          SizedBox(height: 30.0,),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('NOMBRE DE USUARIO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputUserName(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 30.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CONTRASEÑA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                _InputPassword(), // INPUT PARA EL PASSWORD
                SizedBox(height: 30.0,),
                Center(child: _ContrasenaOlvidada()),
                SizedBox(height: 50.0,),
                Center(child: _buttonLogin())
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: ()async{
       _submit();
      },
      child: Text('Ingresar', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        primary: Color(0xff009D47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        )
      ),
    );
  
  }

  void _submit() async {
    final prefs = PreferenciasUsuario();
    if (!formkey.currentState.validate()) return;

    final provider = Provider.of<LoginProvider>(context, listen: false);

    setState(() {
      indicator = true;
    });
    print(provider.usuario + provider.password);
    final socio = await _socioProvider.loginSocio(provider.usuario, provider.password);

    this.indicator=false;
      setState((){
        if(socio!=null){
          print(socio.apMaterno);
            prefs.nombreSocio = '${socio.nombre} ${socio.apPaterno} ${socio.apMaterno} ';
            // prefs.correoSocio = socio.email;
            prefs.correoSocio = 'correo@correo.com';
            Navigator.pushNamed(context, 'menu');
        }else{
          mostrarSnackBar(context, 'Datos Incorrectos');
        }     
    });

    
    
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



class _InputUserName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<LoginProvider>(context, listen: false);

    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nombre de usuario',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
      ),
      onChanged: (value){
        provider.usuario = value;
      },
      validator: (value){
        if (value.length < 1) {
          return 'Ingrese su nombre de usuario';
        } else {
          return null;
        }
      },
    );
  }

}

class _InputPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        // border: 
      ),
      onChanged: (value){
        provider.password = value;
      },
      validator: (value){
        if (value.length < 1) {
          return 'Ingrese su contraseña';
        } else {
          return null;
        }
      },
    );
  }

}


class _ContrasenaOlvidada extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('¿Olvidaste tu contraseña?', style: TextStyle( fontWeight: FontWeight.bold ),);
  }

}