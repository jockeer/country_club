import 'package:country/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff00472B)
      )
    );
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Club',
      initialRoute: 'welcome',
      routes: getAplicationRoutes(),
      
    );
  }
}

