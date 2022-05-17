import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase;

  Future<Database> get _initDatabase async{
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, 'RecordsArchiving.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE archiving(
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
