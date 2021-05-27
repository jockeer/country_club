import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/providers/tarjeta_provider.dart';

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
      SystemUiOverlayStyle(
        statusBarColor: Color(0xff00472B),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light
        // statusBarColor: Colors.,
        
      )
    );
    
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => RegistroProvider(),),
        ChangeNotifierProvider(create: (_)=> LoginProvider(),),
        ChangeNotifierProvider(create: (_)=> ReservaProvider(),),
        ChangeNotifierProvider(create: (_)=> TarjetaProvider(),),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country Club',
        initialRoute: 'welcome',
        routes: getAplicationRoutes(),
        theme: ThemeData(
          primarySwatch: Colors.green
        ),
        
      ),
    );
  }
}

