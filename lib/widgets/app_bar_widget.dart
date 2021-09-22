import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget({ @required String titulo, Color color = Colors.white, Color texto = Colors.black54, arrowClaro = false  }){

  return AppBar(
    title: Text(titulo, style: TextStyle(color: texto,),),
    centerTitle: true, 
    brightness: Brightness.dark, 
    iconTheme: IconThemeData(color: (arrowClaro)?Colors.white:Colors.black),
    backgroundColor: color, 
    elevation: 0.0,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(vertical:5, horizontal: 10),
        child: Image.asset('assets/icons/palmera.png'),
      )
    ],
  );
  
}