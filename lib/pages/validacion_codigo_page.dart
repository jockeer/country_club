import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ValidacionCodigoPage extends StatefulWidget {
  ValidacionCodigoPage({Key key}) : super(key: key);

  @override
  _ValidacionCodigoPageState createState() => _ValidacionCodigoPageState();
}

class _ValidacionCodigoPageState extends State<ValidacionCodigoPage> {
  
  final stateForm = GlobalKey<FormState>();

  final _socioProvider = new SocioService();
  bool indicator = false;


  @override
  Widget build(BuildContext context) {
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
                    Image(image: AssetImage('assets/icons/logo.png'),),
                    _formulario(),
                  ],
                ),
              ),
            ],
          ),
        ),
      inAsyncCall: indicator,
      ),
      floatingActionButton: FloatingButtonWidget(),
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
            key: stateForm,
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CODIGO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                _InputCodigoSocio(),
                SizedBox(height: 20.0,),
                _InputCISocio(),
                SizedBox(height: 20.0,),

                Center(child: _buttonNext()),
              ],
            ),
          ),  
        ],
      ),
    );
  }

  Widget _buttonNext(){
  
    return ElevatedButton(
      onPressed: () async {  
          if (!stateForm.currentState.validate()) return;
          setState(() {
            this.indicator=true;
          });
          final provider = Provider.of<RegistroProvider>(context, listen: false);
          final socio = await _socioProvider.getSocio(provider.codigo, provider.ci); //6038
          this.indicator=false;
          setState((){
            if(socio!=null){
              print(socio.apMaterno);
              Navigator.pushNamed(context, 'register_page_1', arguments: socio);
            }else{
              mostrarSnackBar(context, 'Los datos del socio no son validos por favor actualice su informacion');
            }     
          });
      },
      child: Text('Validar', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
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
      width: phoneSize.width,
      fit: BoxFit.fill,
    );
  }

}

class _InputCodigoSocio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Codigo Socio',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
      ),
      onChanged: (value){
        provider.codigo = value;
      },
      validator: (value){
        if (value.length < 1) {
          return 'Ingrese un valor Valido';
        } else {
          return null;
        }
      },
    );
  }

}
class _InputCISocio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Carnet del Socio',
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
        filled: true,
        fillColor: Colors.white
      ),
      onChanged: (value){
        provider.ci = value;
      },
      validator: (value){
        if (value.length < 1) {
          return 'Ingrese un valor Valido';
        } else {
          return null;
        }
      },
    );
  }

}