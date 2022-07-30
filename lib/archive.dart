import 'dart:typed_data';

class Record{
  
  String recordID = '', recordType = '', dateStored = '', ownerName = '';
  Uint8List document;

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
