import 'package:flutter/material.dart';

import 'package:country/widgets/menu_lateral_widget.dart';

class HistoricoTarjetaPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Tarjeta(),
            _UltimasTransacciones(),
            Image(image: AssetImage('assets/icons/logo.png'), width: phoneSize.width*0.5,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.menu, color: Colors.white,),
        onPressed: (){
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class _Tarjeta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;


    return SafeArea(
      child: Container(
        width: phoneSize.width,
        height: phoneSize.height*0.35,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Tarjeta_consumo.png'),fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Text('Tarjeta de consumo', style: TextStyle(color: Colors.white38, fontSize: phoneSize.width*0.06),),
          ],
        ),
      ),
    );
  }
}

class _UltimasTransacciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          color: Color(0xffC3C3C3),
          width: phoneSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 25.0),
            child: Text('Ultimas transacciones',style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),),
          ),
        ),
        Container(
          height: phoneSize.height*0.5,
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: [
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Reserva cancha de tenis'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 350', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Reserva Cabaña hoyo 19'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 450', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              ListTile(
                title: Text('Almuerzo Familiar'),
                subtitle: Text('30/09/2020 - Comprobante N 450313'),
                trailing: Text('Bs. 150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Divider(color: Colors.black45,),
              
            ],
          ),
        )
      ],
    );
  }
}