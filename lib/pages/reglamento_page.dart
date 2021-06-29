import 'dart:io';

import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ReglamentoPage extends StatelessWidget {
  final pdfService = PdfService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Reglamento'),
      body: FutureBuilder(
        future: pdfService.reglamento('assets/reglamento/reglamento.pdf'),
        builder: (_,AsyncSnapshot<File> snapshot){
          if (snapshot.hasData) {
            return Container(
              child: PDFView(
                filePath: snapshot.data.path,
                swipeHorizontal: true,
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
        
    );
  }
}