import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class HandicapPage extends StatefulWidget {

  @override
  _HandicapPageState createState() => _HandicapPageState();
}

class _HandicapPageState extends State<HandicapPage> {

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Handicap'),
      body: WebView(
        initialUrl: "http://www.golfbolivia.com/handicap/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
         
    );
      
  }
}