import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget appBarWidget({ @required String titulo, Color color = Colors.white, Color texto = Colors.black54, arrowClaro = false, bool centrado= true, bool logo = true, bool logoClaro = false, bool main =false  }){

  return AppBar(
    title: Text(titulo, style: (main)?TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 15.0,
                    color: Colors.black,
                  ),
            ]):TextStyle(color: texto, fontWeight: FontWeight.bold),),
    centerTitle: centrado, 
    systemOverlayStyle: SystemUiOverlayStyle.light, 
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