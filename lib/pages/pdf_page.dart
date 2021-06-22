import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';



class PdfPage extends StatelessWidget {
  final _pdfService = PdfService();

  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarWidget(titulo: 'Evento'),
      body: FutureBuilder(
        future: _pdfService.loadPDF(url),
        builder: (context,AsyncSnapshot snapshot){
          print(snapshot.data);
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