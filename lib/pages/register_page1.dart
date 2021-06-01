import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';
import 'package:country/models/socio_model.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/utils/form_validator.dart';

class RegisterPage1 extends StatefulWidget {

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
 final formState = GlobalKey<FormState>();
 final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {

  final Socio socio = ModalRoute.of(context).settings.arguments;

  final phoneSize = MediaQuery.of(context).size;


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _FondoPantalla(), //FONDO DE PANTALLA DEL LOGIN
            SingleChildScrollView( //FORMULARIO DE LA APP JUNTO CON LA IMAGEN DE FONDO
              child: Column(
                children: [
                  // Image(image: AssetImage('')),
                  SizedBox(height: 80.0,),
                  Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.85,),
                  _formulario(socio),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButtonWidget(color: Colors.black,),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _formulario(Socio socio){

 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          SizedBox(height: 30.0,),
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('NOMBRES(S)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputFirstName(nombreSocio: socio.nombre,), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('APELLIDO(S)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                _InputLastName(apellidoPaterno: socio.apPaterno, apellidoMaterno: socio.apMaterno,),
                SizedBox(height: 20.0,), // INPUT PARA EL PASSWORD
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CORREO ELECTRONICO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputEmail(email: socio.email,), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CONTRASEÑA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputPassword(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                // SizedBox(height: 50.0,),
               
              ],
            ),
          ),
          Center(child: _buttonNext(socio)),
          SizedBox(height: 30.0,),  
        ],
      ),
    );
  

  }
  
  Widget _buttonNext(Socio socio){
  

    return ElevatedButton(
      onPressed: (){
        if (!formState.currentState.validate()) return;
        // print(socio.nombre + socio.ci.toString());
        final provider = Provider.of<RegistroProvider>(context, listen: false);
        socio.email= provider.email;
        socio.password = provider.password;
        // print('desde provider: ' + socio.email + " password: " + socio.password);
        Navigator.pushNamed(context, 'register_page_2', arguments: socio);
      },
      child: Text('Siguiente', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
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
}

class _FondoPantalla extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/backgrounds/fondo_blanco.png'),
      width: phoneSize.width,
      height: phoneSize.height,
      fit: BoxFit.fill,
    );
  }

}



class _InputFirstName extends StatelessWidget {

  final String nombreSocio;

  const _InputFirstName({ @required this.nombreSocio});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.nombreSocio,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nombre',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
      ),
      validator: (value){
        if (value.isEmpty) {
          return 'El nombre no puede quedar Vacio';
        } else {
          return null;
        }
      },
    );
  }

}

class _InputLastName extends StatelessWidget {

  final String apellidoPaterno, apellidoMaterno;

  _InputLastName({ @required this.apellidoPaterno, @required this.apellidoMaterno});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '${this.apellidoPaterno} ${this.apellidoMaterno}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Apellido',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
        // border: 
        
      ),
      validator: (value){
        if (value.isEmpty) {
          return "El apellido no puede quedar Vacio";
        } else {
          return null;
        }
      },
    );
  }

}

class _InputEmail extends StatelessWidget {

  final String email;

  const _InputEmail({@required this.email});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RegistroProvider>(context, listen: false);

    return TextFormField(
      initialValue: this.email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correo electronico',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
        
      ),
      onChanged: (value){
        provider.email = value;
      },
      validator: (value){
        if (value.isEmpty) {
          return 'El correo no puede quedar Vacio';
        }else{
          final formValidator = FormValidator();
          if (formValidator.validarEmail(value)) {
            return null;  
            
          }else{
            return 'Inserte un correo valido';
          }
        }
      },
    );
  }

}

class _InputPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RegistroProvider>(context, listen: false);

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
        
      ),
      onChanged: (value){
        provider.password = value;
      },
      validator: (value){
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        } else {
          return null;
        }
      },
    );
  }

}

