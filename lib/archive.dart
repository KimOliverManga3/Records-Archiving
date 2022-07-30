import 'dart:typed_data';

class Record{
  
  String recordID = '', recordType = '', dateStored = '', ownerName = '';
  late final Uint8List document;

  Record({required this.recordID, 
    required this.recordType, 
    required this.dateStored, 
    required this.ownerName, 
    required this.document});
  
  Map<String, dynamic> toMap() => {
   "document" : document,
   "recordID" : recordID,
   "recordType" : recordType,
   "dateStored" : dateStored,
   "ownerName" : ownerName,
 };
}

// void uploadScannedRecord(Record record) async{ 
//   var db = await DatabaseConnection().database;
//   await db.insert("Archive", record.toMap());
// }

// Future<List<Record>> getRecords() async {
//   var db = await DatabaseConnection().database;
//   List<Map> map = await db.query('archive', columns: ['scannedRecord']);
//   List<Record> record = [];
//   for (int i = 0; i < map.length; i++) {
//     record.add(Record.fromMap(map[i]));
//   }
//   return record;
// }

// class Converter{
//   static Image imageFromBase64String(String base64String) {
//     return Image.memory(
//       base64Decode(base64String),
//     );
//   }
 
//   static Uint8List dataFromBase64String(String base64String) {
//     return base64Decode(base64String);
//   }
 
//   static String base64String(Uint8List data) {
//     return base64Encode(data);
//   }
// }