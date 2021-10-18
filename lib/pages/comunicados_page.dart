import 'package:country/helpers/datos_constantes.dart';
import 'package:country/providers/galeria_provider.dart';
import 'package:country/services/comunicado_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComunicadosPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colores.gris,
        appBar: appBarWidget(
            titulo: 'NOTICIAS',
            color: colores.gris,
            texto: Colors.green,
            logoClaro: true),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: Container(
                      width: size.width,
                      height: size.height * 0.85,
                      color: Colors.white,
                      child: _Comunicados()),
                ),
              )
            ],
          ),
        ));
  }
}

class _Comunicados extends StatelessWidget {
  final comunicadosService = ComunicadosService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: comunicadosService.obtenerComunicadosC(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _Eventos(
            eventos: snapshot.data,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Eventos extends StatelessWidget {
  final List eventos;

  _Eventos({@required this.eventos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            (index == 0)
                ? SizedBox(
                    height: 80,
                  )
                : Container(),
            _Evento(
              evento: eventos[index],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Divider(
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

class _Evento extends StatelessWidget {
  final evento;
  final colores = ColoresApp();
  _Evento({@required this.evento});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
        onTap: () {
          provider.tituloExtra = 2;
          Navigator.pushNamed(context, 'pdf', arguments: this.evento["pdf"]);
        },
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: NetworkImage(this.evento["img"])),
              SizedBox(
                height: 15,
              ),
              Text(
                this.evento["title"].toString().toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfff1a21e)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                this.evento["descripcion"],
                style: TextStyle(color: Color(0xff574e45), height: 1.5),
              ),
            ],
          ),
        ));
  }
}
