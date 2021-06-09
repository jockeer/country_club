import 'package:country/models/reserva_model.dart';
import 'package:flutter/material.dart';

class ReservaWidget extends StatelessWidget {

  final List<Reserva> reservas;

  ReservaWidget({@required this.reservas});
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 4.0,
                offset: Offset(0.0, 5.0), // changes position of shadow
              ),
            ]
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
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
                            Text(reservas[index].nombreCab, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                            Text(
                              reservas[index].estado, 
                              style: TextStyle(
                                fontSize: 14.0 ,
                                color: (reservas[index].status == "2") ? Colors.green : (reservas[index].status =="1")?Colors.orange: ((reservas[index].status =="3"))?Colors.red: Colors.black54,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text('Cantidad: ${reservas[index].cantidad} personas'),
                            SizedBox(height: 5.0,),
                            Text('${reservas[index].fecha}, ${reservas[index].hora}'),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    // Expanded(child: Container(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: (reservas[index].status == "2" || reservas[index].status == "1")
                      ? ([
                          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Reprogramar'),),
                          SizedBox(width: 20.0,),
                          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))) ,child: Text('Cancelar Reserva'),),
                        ])
                      : [
                          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(primary: Color(0xff00472B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))), child: Text('Visualizar Reserva'),),
                        ]    
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}