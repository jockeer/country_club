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
            titulo: 'COMUNICADOS',
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
      future: comunicadosService.obtenerComunicados(context),
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
        return _Evento(
          evento: eventos[index],
        );
      },
    );
  }
}

class _Evento extends StatelessWidget {
  final evento;

  const _Evento({@required this.evento});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
        onTap: () {
          provider.tituloExtra = 2;
          Navigator.pushNamed(context, 'pdf', arguments: this.evento["pdf"]);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: size.width * 0.42,
                  height: size.width * 0.3,
                  child: Image(
                    image: NetworkImage(this.evento["img"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    this.evento["title"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text('${this.evento["desde"]}', style: TextStyle( fontSize: 12, color: Colors.grey ),),
                  // SizedBox(height: 5,),
                  // Text('hasta ${this.evento["until"]}', style: TextStyle( fontSize: 12, color: Colors.grey ),),
                ],
              )
            ],
          ),
        ));
  }
}
