import 'package:country/providers/galeria_provider.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class GaleriaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    final provider = Provider.of<GaleriaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Galeria de fotos', style: TextStyle(color: Colors.black54),),iconTheme: IconThemeData(), backgroundColor: Colors.white, actions: [Image.asset('assets/icons/logo.png')],),
      body: Stack(
        children: [
          _FondoPantalla(),
          _Gallery(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: double.infinity, height: phoneSize.width*0.25, alignment: Alignment.center , child: Text('Pagina 1 / ${provider.pagina}',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingButtonWidget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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

// class _Gallery extends StatefulWidget {

//   @override
//   __GalleryState createState() => __GalleryState();
// }

// class __GalleryState extends State<_Gallery> {
//   bool loading;
//   List<String> ids = ['0', '1' , '10'];
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,

//        ),
//        itemBuilder: (context, index){
//          return Image(image: NetworkImage('https://picsum.photos/300/300?image=${ids[index]}'));
//        },
//        itemCount: ids.length,
//     );
//   }
// }


class _Gallery extends StatefulWidget {

  @override
  __GalleryState createState() => __GalleryState();
}

class __GalleryState extends State<_Gallery> {
  bool loading;
  List<String> ids = ['0', '1' , '10'];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GaleriaProvider>(context);
    return Container(
    child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage('https://picsum.photos/600/600?image=${ids[index]}'),
          minScale: PhotoViewComputedScale.contained
        );
      },
      itemCount: 3,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
          ),
        ),
      ),
      // backgroundDecoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/backgrounds/fondo_blanco.png'))),
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
      // pageController: widget.pageController,
      onPageChanged: (valor){
        provider.pagina = (valor +1 ).toString();
      },
    )
  );
  }
}

