import 'package:country/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';

class RecuperarPassPage extends StatelessWidget {

  final formstate = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _FondoPantalla(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: phoneSize.height*.2,),
                  Text("CONTRASEÑA OLVIDADA", style: TextStyle(fontWeight: FontWeight.w900, fontSize: phoneSize.width*0.05),),
                  SizedBox(height: 50.0,),
                  Form( key: formstate ,child: _Formulario()),
                  SizedBox(height: 50.0,),
                  _ButtonRecoverPass(keyForm: formstate,),
                  SizedBox(height: phoneSize.height*0.3,),
                  Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.5,),
                  SizedBox(height: 20.0,),
                  
                ],
              ),
            )
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
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
          if (value.isEmpty) {
            return "El correo es necesario";
          }
          return null;
        },
      ),
      
    );
  }
}

class _ButtonRecoverPass extends StatelessWidget {

  final GlobalKey<FormState> keyForm;

  const _ButtonRecoverPass({@required this.keyForm});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        if (!this.keyForm.currentState.validate() ) return; 
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Text('Enviar', style: TextStyle(fontSize: 20.0),),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        primary: Color(0xff01954C)
      ),
    );
  }
}