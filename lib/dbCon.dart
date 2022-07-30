import 'package:records_archiving/archive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{

 Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();
  
  Future<Database> initDatabase() async{

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'archived_records.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return _database!;
  }

  Future<void> onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE Archive(recordID INTEGER PRIMARY KEY AUTOINCREMENT, recordType VARCHAR, ownerName VARCHAR, dateStored VARCHAR, document BLOB)');
  }

  void insertContact(Record document) async{ 
    var db = await database;
    await db.insert("Archive", document.toMap()); 
  }

  Future<void> updateRecord(Record updatedRecord, int recordID) async{
    var db = await database;
    await db.update('Archive', updatedRecord.toMap(), where: 'recordID = ?', whereArgs: [recordID]);
  }

  Future<void> deleteRecord(String recordID) async{
    var db = await database;
    await db.delete('Archive', where: 'recordID = ?', whereArgs: [recordID]);
  }

  Future<List<Record>> getDocument() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('Archive');
    return List.generate(maps.length, (i) {
        return Record(
          recordID: maps[i]['recordID'].toString(),
          recordType: maps[i]['recordType'],
          dateStored: maps[i]['dateStored'],
          ownerName: maps[i]['ownerName'],
          document: maps[i]['document'],
        );
    });

  }

  // getContacts2() async {
  //   final db = await database;
  //   final  maps = await db.query('contacts');
  //   inspect(maps);
  // }
}
