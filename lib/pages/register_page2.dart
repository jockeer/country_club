import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/socio_model.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:country/widgets/success_dialog_widget.dart';
import 'package:country/widgets/floating_button_widget.dart';

class RegisterPage2 extends StatefulWidget {
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final form2State = GlobalKey<FormState>();
  bool indicator = false;

  @override
  Widget build(BuildContext context) {
    final Socio socio = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<RegistroProvider>(context);

    return Scaffold(
      backgroundColor:Colors.white,
      body: ModalProgressHUD(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: Stack(
              children: [
                _Formulario(
                  formState: form2State,
                  socio: socio,
                ),
              ],
            ),
          ),
        ),
        inAsyncCall: provider.carga,
      ),
      floatingActionButton: FloatingButtonWidget(
        color: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}


class _Formulario extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final Socio socio;
  final estilos = EstilosApp();

  _Formulario({@required this.formState, @required this.socio});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "INGRESA INFORMACION ADICIONAL",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "Vamos a necesitar alguna informacion tuya para continuar con el registro",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: this.formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                estilos.inputLabel(
                    label: 'Código del socio', obligatorio: true, padding: false ),
                _InputCodigo(
                  codigoSocio: this.socio.codigo,
                ),
                SizedBox(height: 15,),
                estilos.inputLabel(
                    label: 'Numero de Carnet', obligatorio: true, padding: false),
                _InputCi(ci: this.socio.ci),
                SizedBox(height: 15,),
                estilos.inputLabel(label: 'Origen', obligatorio: true, padding: false),
                _InputOrigen(origen: this.socio.origen),
                SizedBox(height: 15,),
                estilos.inputLabel(label: 'Dirección', obligatorio: true, padding: false),
                _InputDireccion(direccion: this.socio.direccion),
                SizedBox(height: 15,),
                estilos.inputLabel(label: 'Teléfono fijo', padding: false),
                _InputTelefono(telefono: this.socio.telefono),
                SizedBox(height: 15,),
                estilos.inputLabel(label: 'Celular', obligatorio: true, padding: false),
                _Celular(
                  celular: this.socio.celular,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: _BotonRegistrarSocio(
                  formState: this.formState,
                  socio: this.socio,
                )),
                Center(
                    child: Image(
                  image: AssetImage('assets/icons/logo.png'),
                  width: 250.0,
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InputCodigo extends StatelessWidget {
  final String codigoSocio;
  final estilos = EstilosApp();
  _InputCodigo({@required this.codigoSocio});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.codigoSocio,
      enabled: false,
      decoration: estilos.inputDecorationinicio(hintText: 'Codigo del socio'),
    );
  }
}

class _InputCi extends StatelessWidget {
  final String ci;
  final estilos = EstilosApp();
  _InputCi({@required this.ci});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      initialValue: this.ci,
      keyboardType: TextInputType.phone,
      decoration: estilos.inputDecorationinicio(hintText: 'Numero de carnet'),
    );
  }
}

class _InputOrigen extends StatelessWidget {
  final String origen;
  final estilos = EstilosApp();
  _InputOrigen({@required this.origen});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.origen,
      enabled: false,
      decoration: estilos.inputDecorationinicio(hintText: 'Origen'),
    );
  }
}

class _InputDireccion extends StatelessWidget {
  final String direccion;
  final estilos = EstilosApp();
  _InputDireccion({@required this.direccion});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return TextFormField(
      initialValue: this.direccion,
      keyboardType: TextInputType.text,
      decoration: estilos.inputDecorationinicio(hintText: 'Direccion'),
      onChanged: (value) {
        provider.direccion = value;
      },
      validator: (value) {
        provider.direccion = value;
        if (value.isEmpty) {
          return "la direccion no puede quedar vacia";
        }
        return null;
      },
    );
  }
}

class _InputTelefono extends StatelessWidget {
  final String telefono;
  final estilos = EstilosApp();
  _InputTelefono({@required this.telefono});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return TextFormField(
      initialValue: this.telefono,
      keyboardType: TextInputType.text,
      decoration: estilos.inputDecorationinicio(hintText: 'Telefono fijo'),
      onChanged: (value) {
        provider.telefono = value;
      },
      validator: (value) {
        provider.telefono = value;
        return null;
      },
    );
  }
}

class _Celular extends StatelessWidget {
  final String celular;
  final estilos = EstilosApp();
  final colores = ColoresApp();

  _Celular({@required this.celular});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    final phoneSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0)),
            color: colores.verdeOscuro,
          ),
          child: DropdownButton(
            icon: Icon(
              Icons.arrow_circle_down_outlined,
              color: Colors.white,
            ),
            isExpanded: true,
            focusColor: Colors.white,
            dropdownColor: Color(0xff009D47),
            underline: Container(
              height: 0.0,
            ),
            value: provider.codtel,
            items: [
              DropdownMenuItem(
                child: Text(
                  '+591',
                  style: TextStyle(color: Colors.white),
                ),
                value: '+591',
              ),
              DropdownMenuItem(
                child: Text(
                  '+111',
                  style: TextStyle(color: Colors.white),
                ),
                value: '+111',
              ),
            ],
            onChanged: (opt) {
              provider.codtel = opt;
            },
          ),
        ),
        Container(
          width: phoneSize.width * 0.4,
          child: TextFormField(
            initialValue: provider.celular,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintText: 'Telefono',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black26)),
                filled: true,
                fillColor: Colors.white),
            onChanged: (value) {
              provider.celular = value;
            },
            validator: (value) {
              provider.celular = value;
              final formValidator = FormValidator();
              if (value.isEmpty || value == '0') {
                return 'ingrese un numero de telefono';
              } else {
                if (!formValidator.isNumeric(value)) {
                  return "Ingrese en telefono válido";
                } else {
                  return null;
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

class _BotonRegistrarSocio extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final Socio socio;
  final estilos = EstilosApp();

  _BotonRegistrarSocio({@required this.formState, @required this.socio});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    final socioService = SocioService();
    return ElevatedButton(
      child: estilos.buttonChild(texto: 'Registrar'),
      style: estilos.buttonStyle(),
      onPressed: () async {
        if (!this.formState.currentState.validate()) return;
        provider.carga = true;
        final conexion = await comprobarInternet();
        if (!conexion) {
          provider.carga = false;
          return showDialog(
              context: context,
              builder: (context) {
                return NoInternetWidget();
              });
        }
        print(socio);
        socio.direccion = provider.direccion;
        socio.celular = provider.celular;
        socio.telefono = provider.telefono;

        final respuesta = await socioService.registrarSocio(socio);
        provider.carga = false;
        if (respuesta != null) {
          if (respuesta.containsKey("error")) {
            mostrarSnackBar(
                context, 'Su tiempo de registro expiro intentelo nuevamente');
            Navigator.pushNamed(context, 'codigo');
            return;
          }
          if (respuesta["Status"]) {
            showDialog(
                context: context,
                builder: (context) {
                  return SuccessDialogWidget(
                      mensaje: 'Socio Registrado Correctamente', ruta: 'login');
                });
          } else {
            mostrarSnackBar(context, respuesta["Message"]);
          }
        } else {
          mostrarSnackBar(context, 'Error al registrar a el socio');
        }
      },
    );
  }
}
