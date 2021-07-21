
import 'dart:io';


import 'package:country/models/mensaje_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class  DBInboxService{
  static Database _databaseInbox;
  static final db =  DBInboxService._();

  DBInboxService._();

  Future<Database>get database async {
    if (_databaseInbox != null) {
      return _databaseInbox;
    }

    _databaseInbox = await initDB();

    return _databaseInbox;
  }

  Future<Database> initDB() async{
    // path de donde almacenaremos la base de datos

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'InboxDB.db' );

    //print(path);

    //Crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{

        await db.execute('''
          create table inbox(
            id integer primary key,
            idNotificacion text,
            titulo text,
            mensaje text,
            fecha text
          )
        ''');
      }
    );
  }

  Future<int>nuevoMensaje(MensajeInbox nuevoMensaje) async {
    final db = await database;

    final validacion = await db.query('inbox',where: 'idNotificacion = ?', whereArgs: [nuevoMensaje.idNotificacion]);
    if (validacion.length != 0) {
    //print("esa notifcacion ya esta registrada");
      return 0;
    }
    final res = await db.insert('inbox', nuevoMensaje.toJson());
    //print("id del mensaje insertada: " + res.toString());
    return res;
  }

  Future<List<MensajeInbox>>getAllMensajes() async{
    final db = await database;

    final res = await db.query('inbox',orderBy: 'id desc');
    // print('Respuesta db');

    return res.isNotEmpty ? res.map((mensaje)=> MensajeInbox.fromJson(mensaje)).toList() :[];
  }
  
  
}