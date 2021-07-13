import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';

class PoliticasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Politicas'),
      body: Column(
        children: [
          Expanded(child: Container()),
          PieLogoWidget()
        ],
      ),
    );
  }
}