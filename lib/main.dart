import 'package:country/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:country/helpers/preferencias_usuario.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff00472B),
        systemNavigationBarIconBrightness: Brightness.light
        
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

