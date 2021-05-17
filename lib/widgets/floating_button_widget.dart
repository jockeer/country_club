import 'package:flutter/material.dart';


class FloatingButtonWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Icon(Icons.arrow_back,color: Colors.black, ),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}