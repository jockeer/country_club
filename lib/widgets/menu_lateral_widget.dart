import 'package:country/helpers/datos_constantes.dart';
import 'package:flutter/material.dart';
import 'package:country/helpers/preferencias_usuario.dart';

class MenuLateralWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final colores = ColoresApp();
    final phoneSize = MediaQuery.of(context).size;
    final prefs = PreferenciasUsuario();
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(top: 30,left: 8,right: 10),
        width: 100,
        decoration: BoxDecoration(
          color: colores.verdeOscuro,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))
        ),
        // height: phoneSize.height*0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/icons/disciplinamenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('DISCIPLINAS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/horariomenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('HORARIOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/mensualidadmenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('MENSUALIDAD', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/tarjetamenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('TARJETA CONSUMO', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/comunicadosmenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('COMUNICADOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/reservasmenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('RESERVAS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/emailmenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('E-MAILS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/menumenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('MENU RESTAURANTE', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/eventosmenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('EVENTOS', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Image(image: AssetImage('assets/icons/soportemenu.png'),width: 25,),
            SizedBox(height: 5,),
            Text('SOPORTE', style: TextStyle(color: colores.verdeMenuLateral, fontSize: 10), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );

    // return Drawer(
    //   child: Container(
    //     color: Colors.white,
    //     child: ListView(
    //       children: [
    //         DrawerHeader(
    //           child: Column(
    //             children: [
    //               Text('BIENVENID@', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0 )),
    //               Expanded(
    //                 child: Row(
    //                   // mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Icon(Icons.person_outlined, color: Colors.green, size: phoneSize.width*0.2,),
    //                     Expanded(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Container(
    //                             width: phoneSize.width*0.5,
    //                             child: Text('${prefs.nombreSocio} ${prefs.apellidoSocio}', 
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold 
    //                               ),
    //                               textAlign: TextAlign.center,
    //                             )
    //                           ),
    //                           Container( width: phoneSize.width*0.5,child: Text('${prefs.correoSocio}', style: TextStyle(color: Colors.black45),textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)),
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //           decoration: BoxDecoration(
    //             // color: Colors.red
    //           ),
    //         ),
    //         Divider(thickness: 2.0, color: Colors.black38, height: 0.0,),
            
    //         _OpcionMenu(icono: Icon(Icons.credit_card, color:Colors.black), titulo: 'Tarjeta de consumo', ruta: 'tarjeta'),
    //         _OpcionMenu(icono: Icon(Icons.history_edu_outlined , color:Colors.black), titulo: 'Histórico de pagos', ruta: 'historico_tarjeta'),
    //         _OpcionMenu(icono: Icon(Icons.file_present_rounded , color:Colors.black), titulo: 'Reservas', ruta: 'reservas_historial'),
    //         _OpcionMenu(icono: Icon(Icons.topic , color:Colors.black), titulo: 'Eventos', ruta: 'eventos'),
    //         _OpcionMenu(icono: Icon(Icons.menu_book, color:Colors.black), titulo: 'Menú', ruta: 'menu'),
    //         _OpcionMenu(icono: Icon(Icons.wine_bar_rounded , color:Colors.black), titulo: 'Hándicap', ruta: 'handicap'),
    //         _OpcionMenu(icono: Icon(Icons.inbox , color:Colors.black), titulo: 'Inbox', ruta: 'inbox'),
    //         _OpcionMenu(icono: Icon(Icons.support_agent, color:Colors.black), titulo: 'Contáctanos', ruta: 'contact'),
    //         _OpcionMenu(icono: Icon(Icons.lock, color:Colors.black), titulo: 'Políticas de privacidad', ruta: 'politicas'),
    //         _OpcionMenu(icono: Icon(Icons.info_outline, color:Colors.black), titulo: 'Acerca del Country Clubs', ruta: 'acerca'),
    //         Divider(),
    //         ListTile(
    //           leading: Icon(Icons.logout, color:Colors.black),
    //           title: Text('Cerrar Sesión'),
    //           onTap: () {
    //             prefs.token = '';
    //             Navigator.pushNamedAndRemoveUntil(context, 'welcome', (route) => false);
    //             // Navigator.pushReplacementNamed(context, 'login');
    //             // Navigator.popUntil(context, ModalRoute.withName('login'));
    //           },
    //         ),
    //         ListTile(
    //           title: Text('Las Palmas Country Club', style: TextStyle(fontSize: 12.0, color: Colors.black45, fontWeight: FontWeight.bold ),),
    //           trailing: Text('V 1.0.3', style: TextStyle(fontSize: 12.0, color: Colors.black45, fontWeight: FontWeight.bold ),),
    //         )
    //       ],
    //     ),
    //   ),

    // );
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
         Navigator.popUntil(context, ModalRoute.withName('main_menu')),
         Navigator.pushNamed(context, this.ruta)
      },
    );
  }
}