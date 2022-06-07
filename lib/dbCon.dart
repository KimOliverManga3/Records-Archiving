import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{

  static Database? _database;

  //Future<Database> get database async => _database ??= await _initDatabase;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('RecordsArchiving.db');

    return _database!;
  }

  Future<Database>  _initDatabase(String dbName) async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    return await db.execute('''
      CREATE TABLE Archive(
        archiveID VARCHAR KEY,
        scannedRecords BLOB,
        dateStored Date
      )
    ''');
  }

  Future close() async{
    var db = await database;
    db.close();
  }
}
