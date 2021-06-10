
import 'package:flutter/material.dart';

class DatosConstantes {

  String dominio = "laspalmascountryclub.com.bo";

}

class ColoresApp{

  Color verdeOscuro = Color(0xff2D5B45);
  Color naranja = Color(0xffF48030);
  Color naranjaClaro = Color(0xffFEA30B);
  Color gris = Color(0xffBABABB);
  Color boton = Color(0xff01954C);

}

class EstilosApp{


  InputDecoration inputDecoration({@required String hintText, double padingTop = 0.0}){
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: padingTop, horizontal: 15.0),
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      filled:true,
      fillColor: Colors.white
    );
  }

  Padding inputLabel({@required String label}){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0
      ), 
      child: Text(label, 
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}