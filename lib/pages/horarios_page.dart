import 'package:country/helpers/datos_constantes.dart';
import 'package:country/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HorariosPage extends StatelessWidget {
  final colores = ColoresApp();
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWidget(titulo: 'HORARIOS', color: colores.fondoVerdeSuperior, texto: Colors.white, arrowClaro: true),
      backgroundColor: colores.fondoVerdeSuperior,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  child: Container(
                    width: size.width,
                    height: size.height*0.85,
                    color: Colors.white,
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          TabBar(
                            isScrollable: true,
                            indicatorColor: colores.verde,
                            indicatorWeight: 3.0,
                            labelColor: Colors.black,
                            tabs: [
                              Tab(child: Text('Administración', style: TextStyle(fontWeight: FontWeight.bold),),),
                              Tab(child: Text('Restaurant', style: TextStyle(fontWeight: FontWeight.bold),),),
                              Tab(child: Text('Servicios', style: TextStyle(fontWeight: FontWeight.bold),),),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _Administracion(),
                                _Restaurant(),
                                _Servicios()
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}

class _Servicios extends StatelessWidget {

  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      children: [
        SizedBox(height: 50,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/peluqueria.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PELUQUERIA', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,), 
                  Text('Lunes a viernes 15:00 a 20:00'),
                  Text('Sábado y domingo (previa reserva)'),
                  Text('Carla Inclan', style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      abrirWhatassp('76333309');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColoresApp().naranjaClaro,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text('763-33309', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/saunas.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SAUNAS', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,), 
                  Text('Lunes a viernes 16:00 a 22:00'),
                  Text('Sábado 11:30 Y 22:00'),
                  Text('Domingo 10:30 a 20:00'),   
                ],
              )
            ),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/gimnasio.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GIMNASIO', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,), 
                  Text('Lunes 12:00 a 22:00'),
                  Text('Martes a viernes 6:00 a 22:00'),
                  Text('Sabado 6:00 a 20:00'),   
                  Text('Domingo 10:00 a 18:00'),   
                ],
              )
            ),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/piscinas.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PISCINAS HABILITADAS', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,), 
                  Text('Lunes a domingo 9:00 a 21:00'),   
                ],
              )
            ),
          ],
        ),
      ],
    );
  }
  void abrirWhatassp(String numero)async{
    var whatsappUrl ="whatsapp://send?phone=591$numero&text=Quisiera%20consultar%20sobre%20los%20horarios";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}

class _Restaurant extends StatelessWidget {
  final estilos = EstilosApp();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      children: [
        SizedBox(height: 50,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/restaurante.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RESTAURANTE', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Text('LA PALMERA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]) ,),  
                  Text('Lunes 12:00 a 22:00'),
                  Text('Martes a domingo de 7:00 a 22:00'),
                  Row(
                    children: [
                      Text('Pedidos: '),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          abrirWhatassp('69051176');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColoresApp().naranjaClaro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('690-51176', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                  
                  
                  
                  SizedBox(height: 20,),
                  Text('HOYO 19', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]) ,),
                  SizedBox(height: 5,),
                  Text('Lunes sin atencion'),
                  Text('Martes, jueves y viernes 7:00 a 21:00'),
                  Text('Miercoles y sabados 7:00 a 23:00'),
                  Text('Domingo 7:00 a 20:00'),
                  Row(
                    children: [
                      Text('Pedidos: '),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          abrirWhatassp('69051176');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColoresApp().naranjaClaro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('690-51176', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        
                        ),
                      ),
                    ],
                  ),
                  
                ],
              )
            )
          ],
        ),
      ],
    );
  }
  void abrirWhatassp(String numero)async{
    var whatsappUrl ="whatsapp://send?phone=591$numero&text=Quisiera%20consultar%20sobre%20los%20horarios";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}

class _Administracion extends StatelessWidget {
  final estilos = EstilosApp();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      children: [
        SizedBox(height: 50,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/administracion.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ADMINISTRACIÓN', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('Lunes a viernes 8:00 a 12:00/15:00 a 19:00'),
                  Text('Sábado 8:30 a 13:00'),
                  SizedBox(height: 15,),
                  Text('GERENCIA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]) ,),  
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      abrirWhatassp('78500967');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColoresApp().naranjaClaro,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text('785-00967', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('ATENCIÓN DE EVENTOS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]) ,),
                  GestureDetector(
                    onTap: (){
                      abrirWhatassp('69016933');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColoresApp().naranjaClaro,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text('690-16933', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('COBRANZAS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]) ,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          abrirWhatassp('78459814');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColoresApp().naranjaClaro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('784-59814', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(width: 15,),
                      GestureDetector(
                        onTap: (){
                          abrirWhatassp('78459815');
                        },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColoresApp().naranjaClaro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('784-59815', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        
                        ),
                      ),
                    ],
                  ),
                ],
              )
            )
          ],
        ),
        SizedBox(height: 40,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 55, child: Image(image: AssetImage('assets/icons/central.png'))),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CENTRAL TELEFONICA', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('Lunes 11:00 a 19:00'),
                  Text('Martes a domingo 7:00 a 22:00'),
                  Row(
                    children: [
                      Text('Whatsapp: '),
                      GestureDetector(
                        onTap: (){
                          abrirWhatassp('78500976');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColoresApp().naranjaClaro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('785 00976', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                  Text('Telf. 3526566 - 78500976'),
                ],
              )
            )
          ],
        ),
      ],
    );
  }
  void abrirWhatassp(String numero)async{
    var whatsappUrl ="whatsapp://send?phone=591$numero&text=Quisiera%20consultar%20sobre%20los%20horarios";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}