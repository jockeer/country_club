import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';



class PdfPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;

    final String extension= url.substring(url.length - 3); 


    return Scaffold(
      appBar: appBarWidget(titulo: 'Evento'),
      body: (extension =='pdf')?_Pdf(url: url,): _Imagen(url: url), 
    );

  }
}

class _Pdf extends StatelessWidget {
  final _pdfService = PdfService();
  final String url;

  _Pdf({@required this.url});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pdfService.loadPDF(url),
      builder: (context,AsyncSnapshot snapshot){
        print(snapshot.data);
        if (snapshot.hasData) {
          if(snapshot.data == 'error'){
            return Center(child: Text('Error al cargar archivo!', style: TextStyle(fontWeight: FontWeight.bold ),),);
          }
          return Container(
            child: PDFView(
              filePath: snapshot.data.path,
              swipeHorizontal: true,
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

class _Imagen extends StatelessWidget {
  final String url;

  _Imagen({@required this.url});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInImage(placeholder: AssetImage('assets/icons/logo.png'), image: NetworkImage(this.url)),
    );
  }
}