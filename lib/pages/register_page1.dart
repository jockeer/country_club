import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';

class RegisterPage1 extends StatefulWidget {

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  @override
  Widget build(BuildContext context) {
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
                  Image(image: AssetImage('assets/icons/logo.png'),),
                  _formulario(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _formulario(){

  final formState = GlobalKey<FormState>();

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
                _InputFirstName(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('APELLIDO(S)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                _InputLastName(),
                SizedBox(height: 20.0,), // INPUT PARA EL PASSWORD
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CORREO ELECTRONICO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputEmail(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CONTRASEÑA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputPassword(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                // SizedBox(height: 50.0,),
                Center(child: _buttonNext()),
                SizedBox(height: 30.0,),  
              ],
            ),
          ),
          
        ],
      ),
    );
  

  }
  
  Widget _buttonNext(){
  

    return ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, 'register_page_2');
      },
      child: Text('Siguiente', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
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
}

class _FondoPantalla extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/backgrounds/fondo_blanco.png'),
      height: phoneSize.height,
      fit: BoxFit.fill,
    );
  }

}



class _InputFirstName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nombre',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
      ),
      validator: (value){
        if (value.length < 1) {
          return '';
        } else {
          return '';
        }
      },
    );
  }

}

class _InputLastName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Apellido',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        // border: 
        
      ),
    );
  }

}

class _InputEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correo electronico',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        // border: 
        
      ),
    );
  }

}
class _InputPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
    );
  }

}

