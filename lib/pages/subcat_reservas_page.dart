import 'package:country/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';

class SubCatReservasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Map<String,dynamic> categoria = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(categoria["titulo"], style: TextStyle(color: Colors.black45),), backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black),),
      drawer: MenuLateralWidget(),
      body: _ListaSubCategorias(),
    );
  }
}

class _ListaSubCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final phoneSize = MediaQuery.of(context).size;

    return ListView(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'reserva_proceso');
          },
          child: Container(
            width: phoneSize.width,
            height: 120.0,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cabaña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),),
                )
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}