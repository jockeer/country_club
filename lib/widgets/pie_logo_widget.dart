import 'package:flutter/material.dart';

class PieLogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize= MediaQuery.of(context).size;
    return Container(
      child: Image(
        image: AssetImage('assets/icons/logo.png'),
        width: phoneSize.width*0.6,
        height: phoneSize.width*0.25,
      ),
    );
  }
}