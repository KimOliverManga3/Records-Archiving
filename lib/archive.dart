import 'dart:convert';
import 'dart:typed_data';
import 'dbCon.dart';
import 'package:flutter/material.dart';


class Record {
  int? archiveID;
  String dateStored = '';
  Uint8List? scannedRecord;

  Record({this.archiveID, required this.scannedRecord});

  Record.fromMap(Map map){
    archiveID = map[archiveID];
    scannedRecord = map[scannedRecord];
 }

  Map<String, dynamic> toMap() => {
   "scannedRecord" : scannedRecord,
 };
}

void uploadScannedRecord(Record record) async{ 
  var db = await DatabaseConnection().database;
  await db.insert("Archive", record.toMap());
}

Future<List<Record>> getRecords() async {
  var db = await DatabaseConnection().database;
  List<Map> map = await db.query('archive', columns: ['scannedRecord']);
  List<Record> record = [];
  for (int i = 0; i < map.length; i++) {
    record.add(Record.fromMap(map[i]));
  }
  return record;
}

class Converter{
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
    );
  }
 
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
 
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}