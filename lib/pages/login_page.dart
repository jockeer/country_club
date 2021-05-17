import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';

class LoginPage extends StatelessWidget {

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
                  _Formulario(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButtonWidget(), //WIDGET CREADO PARA EL BOTON QUE REGRESA
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
      fit: BoxFit.fill,
    );
  }

}

class _Formulario extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.0,),
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
          Center(child: _ButtonLogin())
        ],
      ),
    );
  }

}

class _InputUserName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nombre de usuario',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
      ),
    );
  }

}

class _InputPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
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

class _ButtonLogin extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, 'menu');
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

}

class _ContrasenaOlvidada extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('¿Olvidaste tu contraseña?', style: TextStyle( fontWeight: FontWeight.bold ),);
  }

}