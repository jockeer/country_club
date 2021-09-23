import 'package:country/helpers/datos_constantes.dart';
import 'package:country/widgets/topIcon.dart';
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
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    final Socio socio = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.0,
                    ),
                    TopIcon(),
                    _formulario(socio),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        color: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _formulario(Socio socio) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                estilos.inputLabel( label: 'Nombre(s)', obligatorio: true, padding: false),
                _InputFirstName( nombreSocio: socio.nombre,), 
                SizedBox(height: 15,),
                estilos.inputLabel( label: 'Apellido(s)', obligatorio: true,padding: false),
                _InputLastName( apellidoPaterno: socio.apPaterno, apellidoMaterno: socio.apMaterno,),
                SizedBox(height: 15,),
                estilos.inputLabel( label: 'Correo electrónico', obligatorio: true,padding: false),
                _InputEmail( email: socio.email,), 
                SizedBox(height: 15,),
                estilos.inputLabel( label: 'Contraseña', obligatorio: true,padding: false),
                _InputPassword(),
                SizedBox( height: 30.0,),
              ],
            ),
          ),
          Center(child: _buttonNext(socio)),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _buttonNext(Socio socio) {
    return ElevatedButton(
      onPressed: () {
        if (!formState.currentState.validate()) return;
        // print(socio.nombre + socio.ci.toString());
        final provider = Provider.of<RegistroProvider>(context, listen: false);
        socio.email = provider.email;
        socio.password = provider.password;
        provider.celular = socio.celular;
        // print('desde provider: ' + socio.email + " password: " + socio.password);
        Navigator.pushNamed(context, 'register_page_2', arguments: socio);
        FocusScope.of(context).unfocus();
      },
      child: estilos.buttonChild(texto: 'Siguiente'),
      style: estilos.buttonStyle(),
    );
  }
}


class _InputFirstName extends StatelessWidget {
  final String nombreSocio;
  final estilos = EstilosApp();

  _InputFirstName({@required this.nombreSocio});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.nombreSocio,
      keyboardType: TextInputType.text,
      decoration: estilos.inputDecorationinicio(hintText: 'Nombre'),
      validator: (value) {
        if (value.isEmpty) {
          return 'El nombre no puede quedar Vacío';
        } else {
          return null;
        }
      },
    );
  }
}

class _InputLastName extends StatelessWidget {
  final String apellidoPaterno, apellidoMaterno;
  final estilos = EstilosApp();
  _InputLastName({@required this.apellidoPaterno, @required this.apellidoMaterno});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '${this.apellidoPaterno} ${this.apellidoMaterno}',
      keyboardType: TextInputType.text,
      decoration: estilos.inputDecorationinicio(hintText: 'Apellido'),
      validator: (value) {
        if (value.isEmpty) {
          return "El apellido no puede quedar Vacío";
        } else {
          return null;
        }
      },
    );
  }
}

class _InputEmail extends StatelessWidget {
  final String email;
  final estilos = EstilosApp();
  final formValidator = FormValidator();
  _InputEmail({@required this.email});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);

    return TextFormField(
      initialValue: this.email,
      keyboardType: TextInputType.emailAddress,
      decoration: estilos.inputDecorationinicio(hintText: 'Correo electronico'),
      onChanged: (value) {
        provider.email = value;
      },
      validator: (value) {
        provider.email = value;
        if (value.isEmpty) {
          return 'El correo no puede quedar Vacío';
        } else {
          if (formValidator.validarEmail(value)) {
            return null;
          } else {
            return 'Inserte un correo válido';
          }
        }
      },
    );
  }
}

class _InputPassword extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: false);

    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: estilos.inputDecorationinicio(hintText: 'Contraseña'),
      onChanged: (value) {
        provider.password = value;
      },
      validator: (value) {
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        } else {
          return null;
        }
      },
    );
  }
}
