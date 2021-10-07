import 'package:country/providers/galeria_provider.dart';
import 'package:country/services/pdf_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';

class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<GaleriaProvider>(context);
    final String extension = url.substring(url.length - 3);

    return Scaffold(
      appBar: (extension == 'mp4')
          ? null
          : appBarWidget(
              titulo: (provider.tituloExtra == 1) ? 'Evento' : 'Comunicado'),
      //appBar: appBarWidget(titulo: 'Evento'),
      body: (extension == 'pdf')
          ? _Pdf(
              url: url,
            )
          : (extension == 'mp4')
              ? _Video(url: url)
              : _Imagen(url: url),
      backgroundColor: (extension == 'mp4') ? Colors.black : Colors.white,
      floatingActionButton: (extension == 'mp4')
          ? FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          if (snapshot.data == 'error') {
            return Center(
              child: Text(
                'Error al cargar archivo!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            child: PDFView(
              filePath: snapshot.data.path,
              swipeHorizontal: true,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
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
      child: FadeInImage(
          placeholder: AssetImage('assets/icons/logo.png'),
          image: NetworkImage(this.url)),
    );
  }
}

class _Video extends StatefulWidget {
  final String url;

  _Video({@required this.url});

  @override
  __VideoState createState() => __VideoState();
}

class __VideoState extends State<_Video> {
  VideoPlayerController _controller;
  VoidCallback onClickedFullScreen;
  int orientacion;

  @override
  void initState() {
    super.initState();
    this.orientacion = 1;
    _controller = VideoPlayerController.network(this.widget.url,
        videoPlayerOptions: VideoPlayerOptions())
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllorientations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context).size;
    final size = _controller.value.size;
    return GestureDetector(
        onTap: () {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
          setState(() {});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                (_controller.value.isInitialized)
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: (orientacion == 1) ? size.width : phone.width,
                          height:
                              (orientacion == 1) ? size.height : phone.height,
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
                (_controller.value.isPlaying)
                    ? SizedBox()
                    : Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 80,
                        )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            setLandscape();
                          });
                        },
                        icon: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Future setLandscape() async {
    if (this.orientacion == 1) {
      await SystemChrome.setEnabledSystemUIOverlays([]);
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      this.orientacion = 2;
    } else {
      await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      this.orientacion = 1;
    }
  }

  Future setAllorientations() async {
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
