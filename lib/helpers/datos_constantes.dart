
import 'package:flutter/material.dart';

class DatosConstantes {

  String dominio = "laspalmascountryclub.com.bo";

}

class ColoresApp{

  Color verdeOscuro = Color(0xff204930);
  Color verdeMenuLateral = Color(0xffa9d42d);
  Color verde = Color(0xff225a40);
  Color verdeMarcador = Color(0xffE5F5EC);
  Color verdeClaro = Color(0xff008E3B);
  Color naranja = Color(0xffF48030);
  Color naranjaClaro = Color(0xffFEA30B);
  Color gris = Color(0xffd5d0c9);
  Color boton = Color(0xff008E3B);
  Color fondoVerdeSuperior = Color(0xff3E984C);

}

class EstilosApp{


  InputDecoration inputDecoration({@required String hintText, double padingTop = 0.0}){
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: padingTop, horizontal: 15.0),
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45),borderRadius: BorderRadius.circular(50.0)),
      filled:true,
      fillColor: Colors.white
    );
  }
  InputDecoration inputDecorationinicio({@required String hintText, double padingTop = 0.0}){
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: padingTop, horizontal: 0.0),
      hintText: hintText,
      filled:true,
      fillColor: Colors.white
    );
  }
  InputDecoration inputTarjetaDecoration({@required String hintText, @required String labelText, double padingTop = 0.0}){
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: padingTop, horizontal: 15.0),
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0),borderSide: BorderSide(color: Colors.black45)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45),borderRadius: BorderRadius.circular(50.0)),
      filled:true,
      fillColor: Colors.white
    );
  }

  Padding inputLabel({@required String label, bool obligatorio = false, bool padding = true }){
    return Padding(
      padding: (padding)?EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0
      ) :EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 0.0
      ), 
      child: Row(
        children: [
          Text(label,style: TextStyle(fontWeight: FontWeight.bold),),
           Text((obligatorio)?' *':'',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red),),
        ],
      )
    );
  }

  Padding buttonChild({@required String texto, double fuente = 18.0}){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: Text(texto,style: TextStyle(fontSize: fuente, fontWeight: FontWeight.bold),),
    );
  }
  ButtonStyle buttonStyle({ bool expanded = false}){
    return ElevatedButton.styleFrom(
        minimumSize: (expanded) ? Size(double.infinity, 0) : null,
        primary: ColoresApp().boton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )
      );
  }
  ButtonStyle buttonStyleWap({ bool expanded = false}){
    return ElevatedButton.styleFrom(
        minimumSize: (expanded) ? Size(double.infinity, 0) : null,
        primary: ColoresApp().naranjaClaro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      );
  }
}