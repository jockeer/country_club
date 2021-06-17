import 'package:country/models/mensaje_model.dart';
import 'package:country/services/inbox_servide.dart';
import 'package:flutter/material.dart';

class NotificacionesProvider extends ChangeNotifier{

  List<MensajeInbox> mensajes=[];

  String _titulo;

  cargarNotificaciones()async{
    final mensajes = await DBInboxService.db.getAllMensajes();

    this.mensajes=[...mensajes];

    notifyListeners();
  }

  String get titulo{
    return this._titulo;
  }

  set titulo(String titulo){
    this._titulo = titulo;
    notifyListeners();
  }

}