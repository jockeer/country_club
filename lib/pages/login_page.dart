import 'package:country/helpers/datos_constantes.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/topIcon.dart';
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
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                //FORMULARIO DE LA APP JUNTO CON LA IMAGEN DE FONDO
                child: Column(
                  children: [
                    // Image(image: AssetImage('')),
                    SizedBox(
                      height: size.height * 0.12,
                    ),
                    TopIcon(),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
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
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'welcome');
        },
      ), //WIDGET CREADO PARA EL BOTON QUE REGRESA
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _formulario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                estilos.inputLabel(label: 'Código del socio', padding: false),
                _InputUserName(), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(
                  height: 15,
                ),
                estilos.inputLabel(label: 'Contraseña', padding: false),
                _InputPassword(), // INPUT PARA EL PASSWORD

                SizedBox(
                  height: 30.0,
                ),
                Center(child: _ContrasenaOlvidada()),
                SizedBox(
                  height: 50.0,
                ),
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
      onPressed: () async {
        _submit();
      },
      child: estilos.buttonChild(texto: 'Ingresar'),
      style: estilos.buttonStyle(),
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
      showDialog(
          context: context,
          builder: (context) {
            return NoInternetWidget();
          });
      setState(() {
        indicator = false;
      });
      return;
    }

    final provider = Provider.of<LoginProvider>(context, listen: false);

    // print(provider.usuario + provider.password);
    final socio =
        await _socioProvider.loginSocio(provider.usuario, provider.password);

    setState(() {
      indicator = false;
    });

    // Navigator.pushNamed(context, 'main_menu');
    if (socio != null) {
      //print(socio.apMaterno);
      prefs.nombreSocio = '${socio.nombre}';
      prefs.apellidoSocio = '${socio.apPaterno}';
      prefs.correoSocio = '${socio.email}';
      prefs.codigoSocio = '${socio.codigo}';
      prefs.telefonoSocio = '${socio.celular}';
      prefs.ciSocio = '${socio.ci}';

      Navigator.pushNamed(context, 'main_menu');
      FocusScope.of(context).unfocus();

      setState(() {
        this.indicator = false;
      });
    } else {
      // Navigator.pushNamed(context, 'main_menu');
      mostrarSnackBar(context, 'Datos Incorrectos');
    }
  }
}

class _InputUserName extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: estilos.inputDecorationinicio(hintText: 'Código del socio'),
      onChanged: (value) {
        provider.usuario = value;
      },
      validator: (value) {
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
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: estilos.inputDecorationinicio(hintText: 'Contraseña'),
      onChanged: (value) {
        provider.password = value;
      },
      validator: (value) {
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
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
