import 'package:country/providers/galeria_provider.dart';
import 'package:country/services/cabana_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class GaleriaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final idcabana = ModalRoute.of(context).settings.arguments;
    final cabanasService = CabanaService();
    return Scaffold(
      appBar: appBarWidget(titulo: 'Galeria de fotos'),
      body: Stack(
        children: [
          _FondoPantalla(),
          
          FutureBuilder(
            future: cabanasService.obtenerFotos(idcabana),
            builder: (_, AsyncSnapshot<List> snapshot){
              if (snapshot.hasData) {             
                if (snapshot.data.length==0) {         
                  return Center(child: Text('Esta cabana no tiene fotos de muestra', style: TextStyle(fontWeight: FontWeight.bold) ,),);
                }
                return _Gallery(fotos: snapshot.data,);
              }
              return Center(child: CircularProgressIndicator(),);
            },
          ),
          
        ],
      ),
    );
  }
}

class _FondoPantalla extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/backgrounds/fondo_blanco.png'),
      height: phoneSize.height,
      width: phoneSize.width,
      fit: BoxFit.fill,
    );
  }
}

class _Name extends StatefulWidget {
  final String fotos;

  _Name({ @required this.fotos });

  @override
  __NameState createState() => __NameState();
}

class __NameState extends State<_Name> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.widget.fotos),
    );
  }
}
class _Gallery extends StatefulWidget {

  final List fotos;

  _Gallery({ @required this.fotos });

  @override
  __GalleryState createState() => __GalleryState();
}

class __GalleryState extends State<_Gallery> {
  bool loading;
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GaleriaProvider>(context);
    return Container(
      width: double.infinity,
    child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/cabanas/${this.widget.fotos[index]["foto"]}'),
          minScale: PhotoViewComputedScale.contained
        );
      },
      itemCount: this.widget.fotos.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
          ),
        ),
      ),
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
      onPageChanged: (valor){
        provider.pagina = (valor +1 ).toString();
      },
    )
  );
  }
}

