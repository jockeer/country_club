import 'package:flutter/material.dart';


class FloatingButtonWidget extends StatelessWidget {

  final Color color;

  const FloatingButtonWidget({@required this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Icon(Icons.arrow_back,color: color, ),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}