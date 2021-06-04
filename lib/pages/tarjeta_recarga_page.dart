import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country/providers/tarjeta_provider.dart';
import 'package:country/widgets/menu_lateral_widget.dart';


class RecargaTarjetaPage extends StatelessWidget {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Tarjeta(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
              child: Text("Corte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            ),
            _MontosFijos(),
            SizedBox(height: 30.0,),
            _OtroMonto(),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
              child: Text("Correo electronico", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            ),

            _CorreoBoton(),
            SizedBox(height: 30.0,),
            Center(child: Image(image: AssetImage('assets/icons/logo.png'),width: phoneSize.width*0.5, ))
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

class _OtroMonto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarjetaProvider>(context);
    final phoneSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
            decoration: BoxDecoration(
              color: Color(0xffEBEBEB),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),bottomLeft: Radius.circular(5.0))
            ),
            child: Text('Bs', style: TextStyle(fontSize: 16.0 )),
          ),
          SizedBox(
            width: phoneSize.width*0.3,
            child: TextField(
              
              decoration: InputDecoration(
                hintText: 'Otro monto',
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)), borderSide: BorderSide(color: Colors.black26)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)) ),
                filled: true,
                fillColor: Colors.white
              ),
              onTap: (){
                provider.optRecarga=0;
              },
              onChanged: (value){
                provider.montoRecarga=value;
              },
            ),
          ),
        ],
      ),
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
      ),
    );
  }
}

class _MontosFijos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20.0,),
          _MontoButon(monto: '10',opt: 1,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '20',opt: 2,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '30',opt: 3,),
          SizedBox(width: 10.0,),
          _MontoButon(monto: '50',opt: 4,),

          SizedBox(width: 20.0,),
        ],
      );
  }
}

class _MontoButon extends StatelessWidget {

  final String monto;
  final int opt;

  const _MontoButon({@required this.monto, @required this.opt});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TarjetaProvider>(context);
    return TextButton(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
        child: Text('Bs${this.monto}', style: TextStyle(fontSize: 14.0,),),
      ),
      onPressed: (){
        provider.optRecarga = this.opt;
        provider.montoRecarga = '${this.monto}.00';
      },
      style: TextButton.styleFrom(
        padding:EdgeInsets.zero,
        primary: (provider.optRecarga == this.opt)?Colors.white:Colors.black,
        backgroundColor: (provider.optRecarga == this.opt)?Color(0xff00472B):Color(0xffEBEBEB)
      ),
    );
  }
}
class _CorreoBoton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "E-mail del destinatario",
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.black26)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(50.0) ),
              filled: true,
              fillColor: Colors.white
            ),
          ),
        ),
        SizedBox(height: 50.0,),
        ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, 'metodo_pago');
          }, 
          child: Text('Comprar', style: TextStyle(fontSize: 20.0),),
          style: ElevatedButton.styleFrom(
             elevation: 5.0,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          primary: Color(0xff009D47),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
          ),
        )

      ],
    );
  }
}