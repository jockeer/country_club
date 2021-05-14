import 'package:country/pages/login_page.dart';
import 'package:country/pages/welcome_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'welcome': ( _ ) => WelcomePage(),
    'login': ( _ ) => LoginPage()
  };
}