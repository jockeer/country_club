import 'package:flutter/material.dart';
import 'package:country/widgets/menu_lateral_widget.dart';

class TarjetaPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Tarjeta(),
            _UltimasTransacciones(),
            SizedBox(height: 20.0,),
            Text('Puedes recargar tu tarjeta', style: TextStyle(color: Colors.black45), ),
            SizedBox(height: 10.0,),
            _ButtonRecargar(),
            Image(image: AssetImage('assets/icons/logo.png'), width: 250.0,),
          ],
        )
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
        height: phoneSize.height*0.4,
        color: Color(0xff00472B),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bs.'+ '425', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: phoneSize.width*0.2, decoration: TextDecoration.underline),),
            Text('Tarjeta de consumo', style: TextStyle(color: Colors.white38, fontSize: phoneSize.width*0.06),),
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
          height: phoneSize.height*0.3,
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
              
            ],
          ),
        )
      ],
    );
  }
}

class _ButtonRecargar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()async{
        
        // Navigator.pushNamed(context, 'menu');
      },
      child: Text('Recargar', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        primary: Color(0xff009D47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        )
      ),
    );
  }
}