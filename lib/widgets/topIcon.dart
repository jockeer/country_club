import 'package:flutter/material.dart';

class TopIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(image: AssetImage('assets/icons/logo.png'),width: phoneSize.width*0.65,);
  }
}