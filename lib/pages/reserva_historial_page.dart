import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';

class ReservaHistorialPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservas', style: TextStyle(color: Colors.grey[600]),), backgroundColor: Colors.transparent, elevation: 0.0, iconTheme: IconThemeData(),actions: [Image(image: AssetImage('assets/icons/logo.png'))]),
      drawer: MenuLateralWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: _HistorialLista(),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, 'reservas');
              },
              child: Text('Hacer reserva'),
              style: ElevatedButton.styleFrom(primary: Color(0xff009D47), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
            )
          ],
        ),
      ),
    );
  }
}

class _HistorialLista extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(Icons.redeem),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cabaña La Palmera', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text('Reservada', style: TextStyle(fontSize: 14.0 ,color: Colors.black54),),
                            SizedBox(height: 5.0,),
                            Text('Capacidad 40 personas'),
                            SizedBox(height: 5.0,),
                            Text('Miercoles, 31 de Marzo, 15:30'),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    // Expanded(child: Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B)), child: Text('Reprogramar')),
                        SizedBox(width: 20.0,),
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Colors.red) ,child: Text('Cancelar Reserva')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(thickness: 2.0,),
        Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(Icons.redeem),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cabaña La Palmera', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text('Finalizada', style: TextStyle(fontSize: 14.0 ,color: Colors.black54),),
                            SizedBox(height: 5.0,),
                            Text('Capacidad 40 personas'),
                            SizedBox(height: 5.0,),
                            Text('Miercoles, 31 de Marzo, 15:30'),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    // Expanded(child: Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B)), child: Text('Visualizar Reserva')),
   
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(thickness: 2.0,),
        Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(Icons.redeem),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cabaña La Palmera', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text('Reservada', style: TextStyle(fontSize: 14.0 ,color: Colors.black54),),
                            SizedBox(height: 5.0,),
                            Text('Capacidad 40 personas'),
                            SizedBox(height: 5.0,),
                            Text('Miercoles, 31 de Marzo, 15:30'),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    // Expanded(child: Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B)), child: Text('Reprogramar')),
                        SizedBox(width: 20.0,),
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Colors.red) ,child: Text('Cancelar Reserva')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(thickness: 2.0,),
        Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(Icons.redeem),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cabaña La Palmera', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text('Reservada', style: TextStyle(fontSize: 14.0 ,color: Colors.black54),),
                            SizedBox(height: 5.0,),
                            Text('Capacidad 40 personas'),
                            SizedBox(height: 5.0,),
                            Text('Miercoles, 31 de Marzo, 15:30'),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    // Expanded(child: Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B)), child: Text('Reprogramar')),
                        SizedBox(width: 20.0,),
                        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Colors.red) ,child: Text('Cancelar Reserva')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(thickness: 2.0,),
      ],
    );
  }
}