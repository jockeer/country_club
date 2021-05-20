import 'package:country/models/socio_model.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage2 extends StatefulWidget {

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {

  final form2State = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final Socio socio = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _FondoPantalla(), //FONDO DE PANTALLA DEL LOGIN
            SingleChildScrollView( //FORMULARIO DE LA APP JUNTO CON LA IMAGEN DE FONDO
              child: Column(
                children: [
                  SizedBox(height: 60.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                    child:Column(
                      children: [
                        Text('INGRESA INFORMACION ADICIONAL', style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16.0 ), textAlign: TextAlign.center,),
                        SizedBox(height: 10.0,),
                        Text('Vamos a necesitar alguna informacion tuya para continuar con el registro', style: TextStyle(), textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                  _formulario(socio),
                  Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
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

  Widget _formulario(Socio socio){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        
        children: [
          SizedBox(height: 30.0,),
          Form(
            key: form2State,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('NUMERO DE CARNET DE IDENTIDAD', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputCi(ci: socio.ci.toString(),), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CODIGO DE CLIENTE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                _InputCodigo(),
                SizedBox(height: 20.0,), // INPUT PARA EL PASSWORD
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('ORIGEN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputOrigen(origen: socio.origen,),
                SizedBox(height: 20.0,), // INPUT PARA EL PASSWORD
                // _InputUserName(), 
              ],
            ),
          ),

          SizedBox(height: 50.0,),

          Center(child: _buttonRegister(socio)),
          SizedBox(height: 30.0,),
        ],
      ),
    );
    
  }

  Widget _buttonRegister(Socio socio){
  
    return ElevatedButton(
      onPressed: (){
        // print(socio.email);
        // Navigator.pushNamed(context, 'register_page_2');
        if (!form2State.currentState.validate() ) return;
        Navigator.pushNamed(context, 'login');
        // _mostrarAlerta();
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

  void _mostrarAlerta(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ( context ){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Este es el contenido de la caja de la alerta'),
              FlutterLogo(size: 100,)
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
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


class _InputCi extends StatelessWidget {

  final String ci;

  const _InputCi({@required this.ci});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RegistroProvider>(context);

    return TextFormField(
      initialValue: this.ci,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        enabled: (this.ci.isEmpty ||this.ci == '0' )? true : false,
        hintText: 'Carnet de identidad',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
      ),
      onChanged: (value){
        provider.ci = value;
      },
      validator: (value){
        if (value.isEmpty || value == '0') {
          return 'rellene el carnet de identidad';
        } else {
          return null;
        }
      },
    );
  }

}

class _InputOrigen extends StatelessWidget {

  final String origen;

  const _InputOrigen({ @required this.origen});
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RegistroProvider>(context);

    return TextFormField(
      
      initialValue: this.origen,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        hintText: 'Origen',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        // border: 
        
      ),
      onChanged: (value){
        provider.origen=value;
      },
      validator: (value){
        if (value.isEmpty) {
          return 'El origen no puede estar vacio';
        }
        return null;
      },  
    );
  }

}

class _InputCodigo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return TextFormField(
      initialValue: provider.codigo,
      keyboardType: TextInputType.text,
      // obscureText: true,
      decoration: InputDecoration(
        enabled: false,
        hintText: 'Codigo cliente',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,        
        // border: 
        
      ),
    );
  }

}

