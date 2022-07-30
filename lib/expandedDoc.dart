import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'archive.dart';

class RecordDetails extends StatefulWidget{

  final Record selectedDocument;
  const RecordDetails({required this.selectedDocument});
  
  @override
  RecordDetailsState createState() => RecordDetailsState(selectedDocument: selectedDocument);
}

class RecordDetailsState extends State<RecordDetails> {

  final Record selectedDocument;
  final recordNameController = TextEditingController();
  final ownerNameController = TextEditingController();

  RecordDetailsState({required this.selectedDocument});

  fontEdit()=> GoogleFonts.zillaSlab(
    color: Colors.white,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      title: Text('Record Details'),
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children:[
              const SizedBox(height: 40),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 6, color: Color(0xff36454F)),
                    bottom: BorderSide(width: 6, color: Color(0xff36454F)),
                    right: BorderSide(width: 3, color: Color(0xff36454F)),
                    left: BorderSide(width: 3, color: Color(0xff36454F))
                  ),
                ),
                child: Image.memory(
                  selectedDocument.document,
                  width: 350, 
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.people, color: Color(0xffffffff),),
                  labelStyle: TextStyle(color: Colors.white54),
                  enabled: false
                ),
                style:  fontEdit(),
                initialValue: 'Record Owner: ${selectedDocument.ownerName}',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.file_copy, color: Color(0xffffffff),),
                  labelStyle: TextStyle(color: Colors.white54),
                  enabled: false
                ),
                style:  fontEdit(),
                initialValue: 'Record Type: ${selectedDocument.recordType}',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month, color: Color(0xffffffff),),
                  labelStyle: TextStyle(color: Colors.white54),
                  enabled: false
                ),
                style:  fontEdit(),
                initialValue: 'Date Stored: ${selectedDocument.dateStored}',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers, color: Color(0xffffffff),),
                  labelStyle: TextStyle(color: Colors.white54),
                  enabled: false
                ),
                style:  fontEdit(),
                initialValue: 'Record ID: ${selectedDocument.recordID}',
              ),
            ], 
          ),
        ),
      ),
    ),
  );
}