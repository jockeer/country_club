import 'package:country/pages/acercade_page.dart';
import 'package:country/pages/contact_page.dart';
import 'package:country/pages/historico_tarjeta_dependiente.dart';
import 'package:country/pages/pdf_page.dart';
import 'package:country/pages/politicas_page.dart';
import 'package:country/pages/reglamento_page.dart';
import 'package:flutter/material.dart';

import 'package:country/pages/adminitrar_tarjetas_page.dart';
import 'package:country/pages/detalle_compra_page.dart';
import 'package:country/pages/detalle_pago_membresia_page.dart';
import 'package:country/pages/detalle_recarga_page.dart';
import 'package:country/pages/nueva_tarjetaCredito_page.dart';
import 'package:country/pages/reserva_reprogramar_page.dart';
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
import 'package:country/pages/inbox_page.dart';
import 'package:country/pages/mensualidad_page.dart';
import 'package:country/pages/handicap_page.dart';
import 'package:country/pages/tarjeta_recarga_page.dart';
import 'package:country/pages/metodo_pago_page.dart';

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
    'inbox': ( _ ) => InboxPage(),
    'mensualidad': ( _ ) => MensualidadPage(),
    'handicap': ( _ ) => HandicapPage(),
    'tarjeta_recarga': ( _ ) => RecargaTarjetaPage(), 
    'metodo_pago':( _ ) => MetodoPagoPage(),
    'reserva_repro':( _ ) => ReservaReproPage(),
    'detalle_compra':( _ ) => DetalleCompraPage(),
    'detalle_pago_membresia':( _ ) => DetallePagoMembresia(),
    'detalle_recarga':( _ ) => DetalleRecargaPage(),
    'administrar_tarjetas':( _ ) => AdministrarTarjetasPage(),
    'nueva_tarjeta_credito':( _ ) => NuevaTarjetaCreditoPage(),
    'pdf':( _ ) => PdfPage(),
    'contact':( _ ) => ContactPage(),
    'acerca':( _ ) => AcercaDePage(),
    'politicas':( _ ) => PoliticasPage(),
    'reglamento':( _ ) => ReglamentoPage(),
    'historico_dependiente':( _ ) => HistoricoTarjetaDependiente(),
  };
}