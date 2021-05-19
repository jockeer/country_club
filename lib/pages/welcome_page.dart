import 'package:flutter/material.dart';

import 'package:country/widgets/swipe_widget.dart';

class WelcomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListViewWidget(),
            ButtonsBottom(),
          ],
        ),
      ),
    );
  }
}



class ButtonsBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10.0,),
            Expanded(
              child: _Button(label: 'Ingresa', color: Color(0xff009D47), ruta: 'login') 
            ),
            Expanded(
              child: _Button(label: 'Registrate', color: Color(0xffFF8A00), ruta: 'codigo') 
            ),
            SizedBox(width: 10.0,),
          ],
        ),
        SizedBox(height: 20.0,)
      ],
    );
  }
}

class _Button extends StatelessWidget {

  final String label,ruta;
  final Color color;

  _Button({ @required this.label, @required this.color, @required this.ruta });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.label , style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900), ),
      onPressed: (){
        Navigator.pushNamed(context, this.ruta);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        primary: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        )
      ),
    );
  }
}

