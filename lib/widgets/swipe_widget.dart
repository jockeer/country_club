import 'dart:async';

import 'package:flutter/material.dart';


class ListViewWidget extends StatefulWidget {

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {

  PageController _controladorPageView;
  @override
  void initState() {
    super.initState();
    _controladorPageView = new PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    

  }
  @override
  Widget build(BuildContext context) {
    
    final phoneSize = MediaQuery.of(context).size;
   
    return PageView(
      controller: _controladorPageView,
        
        children: <Widget>[
          Container(
            width: phoneSize.width,
            height: phoneSize.height,
            child: Image(image: AssetImage('assets/backgrounds/fondo_inicio.png'), fit: BoxFit.cover,),
            
          ),    
          Container(
            width: phoneSize.width,
            height: phoneSize.height,
            child: Image(image: AssetImage('assets/backgrounds/fondo_inicio2.png'), fit: BoxFit.cover,),
          ),    
          Container(
            width: phoneSize.width,
            height: phoneSize.height,
            child: Image(image: AssetImage('assets/backgrounds/fondo_inicio3.png'), fit: BoxFit.cover,),
          ),           
        
        ],
      );
  }

  void _animateSlider() {
    if (_controladorPageView.hasClients) {
      
    Future.delayed(Duration(seconds: 3))
      .then((_) {
        int nextPage = _controladorPageView.page.round() + 1;

        if (nextPage == 3) {
          nextPage = 0;
        }

        _controladorPageView.animateToPage(nextPage, duration: Duration(milliseconds: 300), curve: Curves.linear).then((_) => _animateSlider());
      });
    }else{
      // ignore: unnecessary_statements
      _controladorPageView.initialPage;
    }
  }
}