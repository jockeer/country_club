import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

class MenuLateralWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final colores = ColoresApp();

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(top: 30,left: 8,right: 10),
        width: 100,
        decoration: BoxDecoration(
          color: colores.verdeOscuro,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))
        ),
        // height: phoneSize.height*0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/icons/disciplinamenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('DISCIPLINAS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/horariomenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('HORARIOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/mensualidadmenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('MENSUALIDAD', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/tarjetamenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('TARJETA CONSUMO', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/comunicadosmenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('COMUNICADOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/reservasmenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('RESERVAS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/emailmenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('E-MAILS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/menumenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('MENU RESTAURANTE', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/eventosmenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('EVENTOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Image(image: AssetImage('assets/icons/soportemenu.png'),width: 25,),
              SizedBox(height: 5,),
              Text('SOPORTE', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              GestureDetector(onTap: (){Navigator.pushNamed(context, 'welcome');},child: Image(image: AssetImage('assets/icons/soportemenu.png'),width: 25,)),
              SizedBox(height: 5,),
              Text('SOPORTE', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}