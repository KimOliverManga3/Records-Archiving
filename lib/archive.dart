import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import 'dbCon.dart';
import 'dart:io';


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
   "archiveId": archiveID,
   "scannedRecord" : scannedRecord,
 };
}

void uploadScannedRecord(Record record) async{ 
  var db = await DatabaseConnection().database;
  await db.insert("scannedRecord", record.toMap());
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
