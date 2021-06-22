import 'dart:convert';


MensajeInbox mensajeInboxModelFromJson(String str) => MensajeInbox.fromJson(json.decode(str));

String mensajeInboxModelToJson(MensajeInbox data) => json.encode(data.toJson());


class MensajeInbox {

  MensajeInbox({
    this.id,
    this.idNotificacion,
    this.titulo,
    this.mensaje,
    this.fecha
  });

  int id;
  String idNotificacion;
  String titulo;
  String mensaje;
  String fecha;
 

  factory MensajeInbox.fromJson(Map<String, dynamic> json) => MensajeInbox(
      id: json['id'],
      idNotificacion: json['idNotificacion'],
      titulo: json['titulo'],
      mensaje: json['mensaje'],
      fecha: json['fecha'],
  );

  Map<String, dynamic> toJson() => {
    "idNotificacion":idNotificacion,
    "titulo":titulo,
    "mensaje":mensaje,
    "fecha":fecha,
  };
}

