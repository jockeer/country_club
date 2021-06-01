import 'package:country/widgets/app_bar_widget.dart';
import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';


class ReservasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(titulo: 'Reservas'),
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _MenuReservas(),
            Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
          ],
        ),
      ),
    );
  }
}

class _MenuReservas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _OptCabana(titulo: 'La palmera', img: 'La_palmera.png', subcat: 1,),
          _OptCabana(titulo: 'Bar Asai',img: 'Bar_Asai.png', subcat: 2,),
          _OptCabana(titulo: 'El Caribeño',img: 'El_Caribeño.png', subcat: 3,),
          _OptCabana(titulo: 'Cabaña Sumuque',img: 'Cabaña_Sumuque.png', subcat: 4,),
          _OptCabana(titulo: 'Hoyo 19',img: 'Hoyo_19.png', subcat: 5,),
        ],
      ); 
  }
}

class _OptCabana extends StatelessWidget {

  // final Image imagen;
  final String titulo;
  final String img;
  final int subcat;

  const _OptCabana({@required this.img ,@required this.titulo, @required this.subcat});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'reserva_proceso');
      },
      child: Container(
        width: double.infinity,
        height: 150.0,
        child: Stack(
              children: [
                Image(image: AssetImage('assets/images/${this.img}'), fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
                Column(
                  children: [
                    GestureDetector(
                      onTap: ()=>Navigator.pushNamed(context, 'galeria'),
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
                      child: Text(this.titulo, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900, fontSize: 16.0),)
                    )
                  ],
                )
              ],
            ),
      ),
    );
  }
}