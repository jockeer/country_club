import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:country/helpers/datos_constantes.dart';

import 'package:country/services/token_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/floating_button_widget.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/providers/registro_provider.dart';

class ValidacionCodigoPage extends StatelessWidget {

  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    final phoneSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: provider.carga,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  _FondoPantalla(),
                  Column(
                    children: [
                      SizedBox(height: 80.0,),
                      Image(image: AssetImage('assets/icons/logo.png'),width: phoneSize.width*0.85,),
                      _Formulario(formState:formState),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingButtonWidget(color: Colors.black,),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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

class _Formulario extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final estilos = EstilosApp();
  _Formulario({@required this.formState});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Form(
            key: this.formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                estilos.inputLabel(label: 'Código del Socio'),
                _InputCodigoSocio(),
                estilos.inputLabel(label: 'Carnet de identidad'),
                _InputCISocio(),
                SizedBox( height: 20.0,),
                Center(child: _ButtonNext(formState: this.formState,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonNext extends StatelessWidget {
  
  final GlobalKey<FormState> formState;
  final estilos = EstilosApp();
  final socioService = SocioService();
  final tokenService = TokenService();

  _ButtonNext({@required this.formState});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return ElevatedButton(
      style: estilos.buttonStyle(),
      child: estilos.buttonChild(texto: 'Validar'),
      onPressed: ()async {

        if (!this.formState.currentState.validate()) return;
        
        final conexion = await comprobarInternet();
        if (!conexion) return showDialog(context: context, builder: (context){ return NoInternetWidget(); });
        
        provider.carga=true;

        final socio = await socioService.getSocio(provider.codigo, provider.ci);  

        if (socio != null) {
          final message = await tokenService.obtenerToken();
          if (message.isEmpty) {
            mostrarSnackBar(context, "Error con el servidor");
          } else {
            socio.codigo = provider.codigo;
            Navigator.pushNamed(context, 'register_page_1', arguments: socio);
            FocusScope.of(context).unfocus();
          }
        } else {
          mostrarSnackBar(context, 'Los datos del socio no son válidos por favor actualice su informacion');
        }
        provider.carga=false;
      },    
    ); 
  }   
}

class _InputCodigoSocio extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: estilos.inputDecoration(hintText: 'Código Socio'),
      onChanged: (value) {
        provider.codigo = value;
      },
      validator: (value) {
        if (value.length < 1) return 'Ingrese un valor Válido';
        return null;
      },
    );
  }
}

class _InputCISocio extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: estilos.inputDecoration(hintText: 'Carnet del Socio'),
      onChanged: (value) {
        provider.ci = value;
      },
      validator: (value) {
        if (value.length < 1) return 'Ingrese un valor Válido';
        return null;
      },
    );
  }
}
