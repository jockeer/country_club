import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget({ @required String titulo}){

  return AppBar(
    title: Text(titulo, style: TextStyle(color: Colors.black54),), 
    brightness: Brightness.dark, 
    iconTheme: IconThemeData(),
    backgroundColor: Colors.white, 
    elevation: 0.0,
    actions: [
      Image.asset('assets/icons/logo.png')
    ],
  );
  
}