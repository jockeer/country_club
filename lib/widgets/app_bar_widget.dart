import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget({ @required String titulo, Color color = Colors.white, Color texto = Colors.black54, arrowClaro = false, bool centrado= true, bool logo = true, bool logoClaro = false  }){

  return AppBar(
    title: Text(titulo, style: TextStyle(color: texto, fontWeight: FontWeight.bold),),
    centerTitle: centrado, 
    brightness: Brightness.dark, 
    iconTheme: IconThemeData(color: (arrowClaro)?Colors.white:Colors.black),
    backgroundColor: color, 
    elevation: 0.0,
    actions: (logo)
    ? [
      Padding(
        padding: EdgeInsets.symmetric(vertical:5, horizontal: 10),
        child: Image.asset('assets/icons/${logoClaro ?'logoclarosinletra.png' : 'palmera.png'}'),
      )
    ]
    :  [
      
    ]
   ,
  );
  
}