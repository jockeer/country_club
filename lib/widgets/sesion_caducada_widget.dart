import 'package:flutter/material.dart';

class SessionCaducadaWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/icons/error.png'), width:100.0 ),
          Text("Su session cadudo inicie sesion nuevamente", style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            child: Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, 'login', ModalRoute.withName('login'));
              
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              primary: Color(0xff00472B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
            ),
          ),
        ),
      ],
    );
  }
}