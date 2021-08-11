import 'package:country/models/cabana_model.dart';
import 'package:country/providers/galeria_provider.dart';
import 'package:country/providers/reserva_provider.dart';
import 'package:country/services/cabana_service.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/pie_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ReservasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Reservas'),
      body: _MenuReservas(),
    );
  }
}

class _MenuReservas extends StatelessWidget {
  
  final _cabanaService = CabanaService();

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: _cabanaService.obtenerCabanas(),
        builder: (_, AsyncSnapshot<List<Cabana>> snapshot){
          if (snapshot.hasData) {
            return Column(
              children: [
                _Cabanas(cabanas: snapshot.data,),
                PieLogoWidget()
              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      );
  }
}
class _Cabanas extends StatelessWidget {
  final List<Cabana> cabanas;

  _Cabanas({@required this.cabanas});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cabanas.length,
        itemBuilder: (_,index){
          return _OptCabana(titulo: cabanas[index].nombreCabana, foto: cabanas[index].foto, idcab: cabanas[index].id, galeria: 'palmeras', cabanas: this.cabanas, cantidad: cabanas[index].cantidad,);
        },
      ),
    );
  }
}

class _OptCabana extends StatelessWidget {

  final String titulo;
  final String foto;
  final String galeria;
  final String idcab;
  final String cantidad; 
  final List<Cabana> cabanas;

  const _OptCabana({@required this.foto ,@required this.titulo, @required this.idcab, this.galeria, this.cabanas, @required this.cantidad});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservaProvider>(context);
    final providerGaleria = Provider.of<GaleriaProvider>(context);
    return GestureDetector(
      onTap: (){
        provider.codigoCab = this.idcab;
        provider.maxPersonas = this.cantidad;
        Navigator.pushNamed(context, 'reserva_proceso', arguments: this.cabanas);
      },
      child: Container(
        width: double.infinity,
        height: 150.0,
        child: Stack(
          children: [
            FadeInImage(placeholder: AssetImage('assets/images/fondocarga.png'), image: NetworkImage('https://laspalmascountryclub.com.bo/laspalmas/user-files/images/cabanas/$foto'),fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    providerGaleria.galeria=this.galeria;
                    Navigator.pushNamed(context, 'galeria');
                  },
                  child: Container(
                    width: double.infinity, 
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    alignment: Alignment.centerRight,
                    child: Image(image: AssetImage('assets/icons/foto.png'),width: 25.0,),            
                  ),
                ),
                Expanded(child: Container(),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                  color: Colors.black38,
                  width: double.infinity, 
                  child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16.0),)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}