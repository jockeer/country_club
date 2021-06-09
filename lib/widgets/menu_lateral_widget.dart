import 'package:flutter/material.dart';
import 'package:country/helpers/preferencias_usuario.dart';

class MenuLateralWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;
    final prefs = PreferenciasUsuario();

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Text('BIENVENIDO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0 )),
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outlined, color: Colors.green, size: phoneSize.width*0.2,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: phoneSize.width*0.5,
                                child: Text('${prefs.nombreSocio}', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900, 
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                              Container( width: phoneSize.width*0.5,child: Text('${prefs.correoSocio}', style: TextStyle(color: Colors.black45),textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                // color: Colors.red
              ),
            ),
            Divider(thickness: 2.0, color: Colors.black38, height: 0.0,),
            
            _OpcionMenu(icono: Icon(Icons.attach_money_rounded, color:Colors.black), titulo: 'Tarjeta de consumo', ruta: 'tarjeta'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Historico de pagos', ruta: 'historico_tarjeta'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Reservas', ruta: 'reservas_historial'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Eventos', ruta: 'eventos'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Menu', ruta: 'menu'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Ranking', ruta: 'handicap'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Inbox', ruta: 'inbox'),
            _OpcionMenu(icono: Icon(Icons.topic, color:Colors.black), titulo: 'Contactanos', ruta: 'menu'),
            _OpcionMenu(icono: Icon(Icons.lock, color:Colors.black), titulo: 'Politica de privacidad', ruta: 'menu'),
            _OpcionMenu(icono: Icon(Icons.info_outline, color:Colors.black), titulo: 'Acerca de Country Clubs', ruta: 'menu'),
          ],
        ),
      ),

    );
  }
}

class _OpcionMenu extends StatelessWidget {

  final Icon icono;
  final String titulo;
  final String ruta;

  const _OpcionMenu({ @required this.icono, @required this.titulo, @required this.ruta});
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.icono,
      title: Text(this.titulo),
      onTap: () => {
         Navigator.pop(context),
         Navigator.pushNamed(context, this.ruta)
      },
    );
  }
}