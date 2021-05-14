import 'package:country/widgets/swipe_widget.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SwipeWidget(),
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
              child: ElevatedButton(
                child: Text('Ingresa', style: TextStyle(fontSize: 20.0),),
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),    
            ),
            Expanded(
              child: ElevatedButton(
                child: Text('Registrate', style: TextStyle(fontSize: 20.0), ),
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ), 
            ),
            SizedBox(width: 10.0,),
          ],
        )
      ],
    );
  }
}

