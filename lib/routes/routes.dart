import 'package:country/pages/welcome_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'welcome': ( _ ) => WelcomePage()
  };
}