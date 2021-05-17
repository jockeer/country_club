import 'package:flutter/material.dart';

import 'package:country/pages/welcome_page.dart';
import 'package:country/pages/login_page.dart';
import 'package:country/pages/register_page1.dart';
import 'package:country/pages/register_page2.dart';
import 'package:country/pages/menu_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'welcome': ( _ ) => WelcomePage(),
    'login': ( _ ) => LoginPage(),
    'register_page_1': ( _ ) => RegisterPage1(),
    'register_page_2': ( _ ) => RegisterPage2(),
    'menu': ( _ ) => MenuPage(),
    
  };
}