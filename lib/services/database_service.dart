

import 'dart:io';

import 'package:country/models/credit_card_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class  DBService{
  static Database _database;
  static final db =  DBService._();

  DBService._();

  Future<Database>get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{
    // path de donde almacenaremos la base de datos

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'TarjetasDB.db' );

    print(path);

    //Crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{

        await db.execute('''
          create table tarjetas(
            id integer primary key,
            cardNumberHidden text,
            cardNumber text,
            brand text,
            cvv text,
            expiracyDate text,
            cardHolderName text
          )
        ''');
      }
    );
  }

  Future<int>nuevaTarjeta(TarjetaCredito nuevaTarjeta) async {
    final db = await database;

    final res = await db.insert('tarjetas', nuevaTarjeta.toJson());
    print("id de la tarjeta insertada: " + res.toString());
    return res;
  }

  Future<List<TarjetaCredito>>getAllTarjetas() async{
    final db = await database;

    final res = await db.query('tarjetas');

    return res.isNotEmpty ? res.map((tarjeta)=> TarjetaCredito.fromJson(tarjeta)).toList() :[];
  }

  Future<int> deleteAll() async {

    final db  = await database;
    final res = await db.rawDelete('DELETE FROM tarjetas');

    print("cantidad de registros eliminados: " + res.toString());
    return res;
  }
  
}