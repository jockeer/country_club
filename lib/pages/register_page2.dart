import 'package:country/helpers/datos_constantes.dart';
import 'package:country/models/socio_model.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/services/socio_service.dart';
import 'package:country/utils/comprobar_conexion.dart';
import 'package:country/utils/form_validator.dart';
import 'package:country/utils/show_snack_bar.dart';
import 'package:country/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/floating_button_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegisterPage2 extends StatefulWidget {
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final form2State = GlobalKey<FormState>();
  final colores = ColoresApp();
  final socioSerice = SocioService();
  bool indicator = false;

  @override
  Widget build(BuildContext context) {
    final Socio socio = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: ModalProgressHUD(
        child: SafeArea(
          child: Stack(
            children: [
              _FondoPantalla(), //FONDO DE PANTALLA DEL LOGIN
              SingleChildScrollView(
                //FORMULARIO DE LA APP JUNTO CON LA IMAGEN DE FONDO
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 30.0),
                      child: Column(
                        children: [
                          Text(
                            'INGRESA INFORMACION ADICIONAL',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Vamos a necesitar alguna informacion tuya para continuar con el registro',
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    _formulario(socio),
                    Image(
                      image: AssetImage('assets/icons/logo.png'),
                      width: 250.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: indicator,
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
            key: form2State,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text(
                    'NUMERO DE CARNET DE IDENTIDAD',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _InputCi(
                  ci: socio.ci.toString(),
                ), //INPUT DONDE ESTA EL NOMBRE DE USUARIO
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text('CODIGO DE CLIENTE',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                _InputCodigo(),
                SizedBox(
                  height: 20.0,
                ), // INPUT PARA EL PASSWORD
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text(
                    'ORIGEN',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _InputOrigen(
                  origen: socio.origen,
                ),
                SizedBox(
                  height: 20.0,
                ), // INPUT PARA EL PASSWORD
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text(
                    'DIRECCION',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _InputDireccion(
                  direccion: socio.direccion,
                ),
                SizedBox(
                  height: 20.0,
                ), // INPUT PARA EL PASSWORD
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                  child: Text(
                    'TELEFONO',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _InputTelefono(),
                // INPUT PARA EL PASSWORD
                // _InputUserName(),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(child: _buttonRegister(socio)),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _buttonRegister(Socio socio) {
    return ElevatedButton(
      onPressed: () async {
        if (!form2State.currentState.validate()) return;

        final provider = Provider.of<RegistroProvider>(context, listen: false);

        setState(() {
          indicator = true;
        });

        final conexion = await comprobarInternet();
        if (!conexion) {
          setState(() {
            indicator = false;
          });

          showDialog(
              context: context,
              builder: (context) {
                return NoInternetWidget();
              });

          return;
        }

        socio.telefono = provider.codtel + provider.telefono;
        socio.direccion = provider.direccion;

        final resultado = await socioSerice.registrarSocio(socio);
        if (resultado["Status"] == false) {
          mostrarSnackBar(context, resultado["Message"]);
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _DialogInfo(
                  message: resultado["Message"],
                );
              });
          print('True papa');
        }
        setState(() {
          indicator = false;
        });
        // Navigator.pushNamed(context, 'login');
      },
      child: Text(
        'Siguiente',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          primary: colores.boton,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0))),
    );
  }
}

class _DialogInfo extends StatelessWidget {
  final String message;

  const _DialogInfo({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/icons/success.gif'), width: 150.0),
          Text(this.message)
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            child: Text(
              'Aceptar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'login');
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                primary: Color(0xff00472B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
      ],
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
          enabled: (this.ci.isEmpty || this.ci == '0') ? true : false,
          hintText: 'Carnet de identidad',
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(50.0)),
          filled: true,
          fillColor: Colors.white),
      onChanged: (value) {
        provider.ci = value;
      },
      validator: (value) {
        provider.ci = value;
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

  const _InputOrigen({@required this.origen});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);

    return TextFormField(
      initialValue: this.origen,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Origen',
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(50.0)),
          filled: true,
          fillColor: Colors.white
          // border:

          ),
      onChanged: (value) {
        provider.origen = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'El origen no puede estar vacío';
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(50.0)),
          filled: true,
          fillColor: Colors.white
          // border:

          ),
    );
  }
}

class _InputDireccion extends StatelessWidget {
  final String direccion;

  const _InputDireccion({@required this.direccion});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    return TextFormField(
      initialValue: this.direccion,
      keyboardType: TextInputType.text,
      // obscureText: true,
      decoration: InputDecoration(
          enabled: true,
          hintText: 'Direccion',
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(50.0)),
          filled: true,
          fillColor: Colors.white
          // border:

          ),
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

class _InputTelefono extends StatefulWidget {
  @override
  __InputTelefonoState createState() => __InputTelefonoState();
}

class __InputTelefonoState extends State<_InputTelefono> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: true);

    final phoneSize = MediaQuery.of(context).size;
    final colores = ColoresApp();

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
              // DropdownMenuItem(child: Text('+222',style: TextStyle(color: Colors.white),), value: '+222',),
              // DropdownMenuItem(child: Text('+333',style: TextStyle(color: Colors.white),), value: '+333',),
            ],
            onChanged: (opt) {
              provider.codtel = opt;
            },
          ),
        ),
        Container(
          width: phoneSize.width * 0.4,
          child: TextFormField(
            keyboardType: TextInputType.text,
            // obscureText: true,
            decoration: InputDecoration(
                hintText: 'Telefono',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black26)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
                filled: true,
                fillColor: Colors.white),
            onChanged: (value) {
              provider.telefono = value;
            },
            validator: (value) {
              final formValidator = FormValidator();
              if (value.isEmpty) {
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
