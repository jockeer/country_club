import 'package:flutter/material.dart';

class SuccessDialogWidget extends StatelessWidget {
  final String mensaje;
  final String ruta;

  SuccessDialogWidget({@required this.mensaje, @required this.ruta});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/icons/success.gif'), width: 100.0),
          Text(
            this.mensaje,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
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
              if (this.ruta == 'main_menu') {
                Navigator.popUntil(context, ModalRoute.withName('main_menu'));
              } else {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, this.ruta);
                // Navigator.popUntil(context, ModalRoute.withName(this.ruta));

              }
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
