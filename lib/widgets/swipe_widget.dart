import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListViewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: size.height,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal
      ),
      items: [
        Image(image: AssetImage('assets/backgrounds/fondo_inicio.jpg'), fit: BoxFit.fill,width: size.width, height: size.height,),
        Image(image: AssetImage('assets/backgrounds/fondo_inicio2.jpg'), fit: BoxFit.fill,width: size.width, height: size.height,),
        Image(image: AssetImage('assets/backgrounds/fondo_inicio3.jpg'), fit: BoxFit.fill,width: size.width, height: size.height,)
      ],
    );
  }
}