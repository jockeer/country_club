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
      body: ModalProgressHUD(
        child: SafeArea(
<<<<<<< HEAD
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
=======
          child: GestureDetector(
            onTap: (){
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: Stack(
              children: [
                _FondoPantalla(), //FONDO DE PANTALLA DEL LOGIN
                _Formulario(formState: form2State, socio: socio,),
              ],
            ),
          ),
        ),
        inAsyncCall: provider.carga,
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
      ),
      floatingActionButton: FloatingButtonWidget(color: Colors.black,),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

<<<<<<< HEAD
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
=======
}

>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544

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
  final Socio socio;
  final estilos = EstilosApp();

<<<<<<< HEAD
class _InputCi extends StatelessWidget {
  final String ci;
=======
  _Formulario({@required this.formState, @required this.socio});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          SizedBox(height: 50.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text("INGRESA INFORMACION ADICIONAL", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold) ,),
          ),
          SizedBox(height: 5.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text("Vamos a necesitar alguna informacion tuya para continuar con el registro", textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0),),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: this.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  estilos.inputLabel(label: 'Codigo del Socio',obligatorio: true),
                  _InputCodigo(codigoSocio: this.socio.codigo,),
                  estilos.inputLabel(label: 'Numero de Carnet',obligatorio: true),
                  _InputCi(ci: this.socio.ci),
                  estilos.inputLabel(label: 'Origen',obligatorio: true),
                  _InputOrigen(origen: this.socio.origen),
                  estilos.inputLabel(label: 'Direccion',obligatorio: true),
                  _InputDireccion(direccion: this.socio.direccion),
                  estilos.inputLabel(label: 'Telefono Fijo'),
                  _InputTelefono(telefono: this.socio.telefono),
                  estilos.inputLabel(label: 'Celular', obligatorio: true),
                  _Celular(celular: this.socio.celular,),
                  SizedBox(height: 20.0,),
                  Center(child: _BotonRegistrarSocio(formState: this.formState,socio: this.socio,)),
                  Center(child: Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,))
                ],
              ),
            ),
          )
        ],
      );
  }
}

class _InputCodigo extends StatelessWidget {
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544

  final String codigoSocio;
  final estilos = EstilosApp();
  _InputCodigo({@required this.codigoSocio});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final provider = Provider.of<RegistroProvider>(context);

=======
    return TextFormField(
      initialValue: this.codigoSocio,
      enabled: false,
      decoration: estilos.inputDecoration(hintText: 'Codigo del socio'),
    );     
  }
}

class _InputCi extends StatelessWidget {

  final String ci;
  final estilos = EstilosApp();
  _InputCi({@required this.ci});

  @override
  Widget build(BuildContext context) {
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
    return TextFormField(
      enabled: false,
      initialValue: this.ci,
      keyboardType: TextInputType.phone,
<<<<<<< HEAD
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
=======
      decoration: estilos.inputDecoration(hintText: 'Numero de carnet'),
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
    );
  }
}

class _InputOrigen extends StatelessWidget {
  final String origen;
<<<<<<< HEAD

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
=======
  final estilos = EstilosApp();
  _InputOrigen({ @required this.origen});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.origen,
      enabled: false,
      decoration: estilos.inputDecoration(hintText: 'Origen'),
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
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
<<<<<<< HEAD
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
=======
      decoration: estilos.inputDecoration(hintText: 'Direccion'),
      onChanged: (value){
        provider.direccion = value;
      },
      validator: (value){
        provider.direccion = value;
        if(value.isEmpty){
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
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
      decoration: estilos.inputDecoration(hintText: 'Telefono fijo'),
      onChanged: (value){
        provider.telefono = value;
      },
      validator: (value){
        provider.telefono=value;
        return null;
      },
    );
  }
}

<<<<<<< HEAD
class __InputTelefonoState extends State<_InputTelefono> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context, listen: true);
=======
class _Celular extends StatelessWidget {
  final String celular;
  final estilos = EstilosApp();
  final colores = ColoresApp();

  _Celular({ @required this.celular});
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544

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
<<<<<<< HEAD
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
=======
              DropdownMenuItem(child: Text('+591', style: TextStyle(color: Colors.white),), value: '+591',),
              DropdownMenuItem(child: Text('+111', style: TextStyle(color: Colors.white),), value: '+111',),

            ],
            onChanged: (opt){
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
              provider.codtel = opt;
            },
          ),
        ),
        Container(
          width: phoneSize.width * 0.4,
          child: TextFormField(
<<<<<<< HEAD
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
=======
            initialValue: provider.celular,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Telefono',
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(50.0),bottomRight:Radius.circular(50.0) ), borderSide: BorderSide(color: Colors.black26)),
              filled: true,
              fillColor: Colors.white        
            ),
            onChanged: (value){
              provider.celular=value;
            },
            validator: (value){
              provider.celular=value;
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
              final formValidator = FormValidator();
              if (value.isEmpty || value =='0') {
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
<<<<<<< HEAD
=======

class _BotonRegistrarSocio extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final Socio socio;
  final estilos =EstilosApp();

  _BotonRegistrarSocio({@required this.formState, @required this.socio});
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistroProvider>(context);
    final socioService = SocioService();
    return ElevatedButton(
      child: estilos.buttonChild(texto: 'Registrar'),
      style: estilos.buttonStyle(),
      onPressed: ()async{
        if (!this.formState.currentState.validate()) return;
        provider.carga=true;
        final conexion = await comprobarInternet();
        if(!conexion){
          provider.carga=false;
          return showDialog(context: context, builder: (context){return NoInternetWidget();});
        }
        print(socio);
        socio.direccion = provider.direccion;
        socio.celular=provider.celular;
        socio.telefono = provider.telefono;

        final respuesta = await socioService.registrarSocio(socio);
        provider.carga=false;
        if (respuesta != null) {
          if (respuesta.containsKey("error")) {
            mostrarSnackBar(context, 'Su tiempo de registro expiro intentelo nuevamente');
            Navigator.pushNamed(context, 'codigo');
            return;
          }
          if (respuesta["Status"]) {
            showDialog(context: context, builder: (context){return SuccessDialogWidget(mensaje: 'Socio Registrado Correctamente', ruta: 'login');});
            
          }else{
            mostrarSnackBar(context, respuesta["Message"]);

          }
        }else{
          mostrarSnackBar(context, 'Error al registrar el socio');
        }
      },
    );
  }
}
>>>>>>> 6f97f50eb103f77756bb75326511832b4df73544
