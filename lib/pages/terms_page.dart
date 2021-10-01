import 'dart:io';

import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class TerminosPage extends StatelessWidget {
  final pdfService = PdfService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Términos y Condiciones'),
      body: FutureBuilder(
        future: pdfService.terminos('assets/reglamento/terminos.pdf'),
        builder: (_,AsyncSnapshot<File> snapshot){
          if (snapshot.hasData) {
            return Container(
              child: PDFView(
                filePath: snapshot.data.path,
                swipeHorizontal: false,
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
        
    );
  }
}