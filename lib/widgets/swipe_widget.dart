import 'dart:async';

import 'package:flutter/material.dart';


class ListViewWidget extends StatefulWidget {

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  int _currentPage = 0;

  PageController _controladorPageView = new PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  

    Timer.periodic(new Duration(seconds: 3), (Timer timer) {
      if (_currentPage <= 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controladorPageView.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });

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
}