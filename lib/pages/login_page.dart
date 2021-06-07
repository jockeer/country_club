import 'package:country/helpers/datos_constantes.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/utils/show_snack_bar.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  bool indicator = false;
  final _socioProvider = new SocioService();
  final colores = ColoresApp();

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
                  child: Text('CODIGO DE SOCIO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
        primary: colores.boton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        )
      ),
    );
  
  }

  void _submit() async {
    final prefs = PreferenciasUsuario();
    if (!formkey.currentState.validate()) return;

    setState(() {
      indicator = true;
    });
    final conectado = await comprobarInternet();

    if (!conectado) {
      showDialog(context: context, builder: (context){return NoInternetWidget();});
      setState(() {
        indicator = false;
      });
      return;
      
    }
    

    final provider = Provider.of<LoginProvider>(context, listen: false);

    // print(provider.usuario + provider.password);
    final socio = await _socioProvider.loginSocio(provider.usuario, provider.password);

    setState(() {
      indicator = false;
    });
    
    // Navigator.pushNamed(context, 'main_menu');
    if(socio != null){
      print(socio.apMaterno);
        prefs.nombreSocio = '${socio.nombre} ${socio.apPaterno}';
        prefs.correoSocio = '${socio.email}';
        prefs.codigoSocio = '${socio.codigo}';

        Navigator.pushNamed(context, 'main_menu');
    
        setState((){
          this.indicator=false;
        });
    }else{
        // Navigator.pushNamed(context, 'main_menu');
      mostrarSnackBar(context, 'Datos Incorrectos');
    }       
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Codigo de socio',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
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
    return GestureDetector(
      onTap: () async {
        
        Navigator.pushNamed(context, 'recuperar_password');
      },
      child: Text('¿Olvidaste tu contraseña?', style: TextStyle( fontWeight: FontWeight.bold ),)
    );
  }

}