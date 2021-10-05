import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';

import 'package:country/widgets/swipe_widget.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ListViewWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage('assets/icons/logoconletraploma.png'),
                    width: size.width * 0.6),
                SizedBox(
                  height: size.height * 0.15,
                ),
                Text(
                  'Disfruta una nueva experiencia',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ColoresApp().verde,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ButtonsBottom(),
        ],
      ),
    );
  }
}

class ButtonsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colores = ColoresApp();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: _Button(
                    label: 'INGRESAR',
                    color: colores.verdeClaro,
                    ruta: 'login')),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: _Button(
                    label: 'REGISTRATE',
                    color: colores.verdeClaro,
                    ruta: 'codigo')),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String label, ruta;
  final Color color;

  _Button({@required this.label, @required this.color, @required this.ruta});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        this.label,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushNamed(context, this.ruta);
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          primary: this.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0))),
    );
  }
}
