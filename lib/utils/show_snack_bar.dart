import 'package:flutter/material.dart';

void mostrarSnackBar(BuildContext context, String mensaje){
  final SnackBar snackBar = new SnackBar(
              backgroundColor: Colors.red,
              content: Text(mensaje),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);  
}