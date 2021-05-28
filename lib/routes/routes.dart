import 'package:flutter/material.dart';

import 'package:country/pages/welcome_page.dart';
import 'package:country/pages/login_page.dart';
import 'package:country/pages/register_page1.dart';
import 'package:country/pages/register_page2.dart';
import 'package:country/pages/main_menu_page.dart';
import 'package:country/pages/reservas_page.dart';
import 'package:country/pages/reserva_historial_page.dart';
import 'package:country/pages/reserva_proceso_page.dart';
import 'package:country/pages/tarjeta_page.dart';
import 'package:country/pages/tarjeta_historico_page.dart';
import 'package:country/pages/validacion_codigo_page.dart';
import 'package:country/pages/recuperar_contrasena_page.dart';
import 'package:country/pages/menu_page.dart';
import 'package:country/pages/galeria_page.dart';
import 'package:country/pages/eventos_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'welcome': ( _ ) => WelcomePage(),
    'login': ( _ ) => LoginPage(),
    'codigo': ( _ ) => ValidacionCodigoPage(),
    'register_page_1': ( _ ) => RegisterPage1(),
    'register_page_2': ( _ ) => RegisterPage2(),
    'main_menu': ( _ ) => MainMenuPage(),
    'menu': ( _ ) => MenuPage(),
    'reservas_historial': ( _ ) => ReservaHistorialPage(),
    'reservas': ( _ ) => ReservasPage(),
    'reserva_proceso': ( _ ) => ReservaProcesoPage(),
    'galeria': ( _ ) => GaleriaPage(),
    'tarjeta': ( _ ) => TarjetaPage(),
    'historico_tarjeta': ( _ ) => HistoricoTarjetaPage(),
    'recuperar_password': ( _ ) => RecuperarPassPage(),
    'eventos': ( _ ) => EventosPage(),
    
    
  };
}