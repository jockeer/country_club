import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/disciplina_provider.dart';
import 'package:country/providers/eventos_provider.dart';
import 'package:country/providers/tarjetas_credito_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:country/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/registro_provider.dart';
import 'package:country/providers/login_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/providers/galeria_provider.dart';
import 'package:country/providers/notificacion_provider.dart';
import 'package:country/services/push_notificacion_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  await PushNotificationService.initializeApp();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://66e844007e0441a2b7c337ce05dbb172@o880564.ingest.sentry.io/5862979';
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();

    final colores = ColoresApp();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: colores.verdeOscuro,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistroProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReservaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TarjetaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GaleriaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificacionesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TarjetasCreditoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventosProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DisciplinaProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country Club',
        // initialRoute: (prefs.token==''||prefs.token==null)?'menu':'menu',
        initialRoute: (prefs.token == '' || prefs.token == null)
            ? 'welcome'
            : 'main_menu',
        routes: getAplicationRoutes(),
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat',backgroundColor: Colors.white),
      ),
    );
  }
}
