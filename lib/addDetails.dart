import 'dart:io';
import 'dart:typed_data';
import 'dbCon.dart';
import 'archive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDetails extends StatefulWidget{

  String docType, ownerName, dateStored, recordID;
  var doc;
  
  AddDetails({required this.docType, required this.ownerName, required this.doc, required this.dateStored, required this.recordID});

  @override
  AddDetailsState createState() => AddDetailsState(docType, ownerName, doc, dateStored, recordID);

}

class AddDetailsState extends State<AddDetails> {

  String recordType = '', ownerName = '', recordID = '', buttonText = 'Save';
  String dateStored = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late final Uint8List tempDoc;
  int recordIDtoParse = 0;

  final recordNameController = TextEditingController();
  final ownerNameController = TextEditingController();

  AddDetailsState(this.recordType, this.ownerName, this.tempDoc, this.dateStored, this.recordID){
    if(recordType.isNotEmpty && ownerName.isNotEmpty && tempDoc.isNotEmpty){
     recordNameController.text = recordType;
     ownerNameController.text = ownerName;
     buttonText = 'Update';
    }
  }

   String? validateOwnerName(value){
    if(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return "Invalid Format, Please use Letters Only.";
    } else {
      ownerName = value;
      return null;
    }
  }

  String? validateRecordName(value){
    if(value.isEmpty) {
      return "Error, Record Type is Empty.";
    } else{
      recordType = value;
      return null;
    }
  }

  Future recordPicker() async{
  bool checker = false;
  int tempID = 0;
   try{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) {
      return null;
    } else{
      File imageFile = File(image.path);
      setState(() async {
        tempDoc = await imageFile.readAsBytes();
      });
      
      var db = await DatabaseConnection().database;
      while(checker == false){
        var temp = await db.rawQuery("SELECT * FROM Archive WHERE recordID = '$tempID'");
        if(temp.length > 0){
          tempID++;
        }
        else{
          recordIDtoParse = tempID;
          break;
        }
      }
    }
   }on Exception catch(e){
    print('$e');
   }
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      title: Text('Insert Credentials'),
    ),
    body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: ownerNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Owner's Name",
                  labelStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.people, color: Color(0xffffffff),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 3),
                    borderRadius: BorderRadius.circular(30.0), 
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blueGrey, width: 3),
                    borderRadius: BorderRadius.circular(30.0)
                  )
                ),
                validator: validateOwnerName,
              ),
              const SizedBox(height: 25.0,),
              TextFormField(
                controller: recordNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Record Type",
                  labelStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.people, color: Color(0xffffffff),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 3),
                    borderRadius: BorderRadius.circular(30.0), 
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blueGrey, width: 3),
                    borderRadius: BorderRadius.circular(30.0)
                  )
                ),
                 validator: validateRecordName,
              ),
              const SizedBox(height: 25.0,),
              
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    textStyle: TextStyle(fontSize: 16),
                    primary: Colors.transparent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    side: const BorderSide(
                      color: Colors.white38,
                      width: 3
                    )
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.image),
                      const SizedBox(width: 20),
                      Text('Select Image')
                    ],
                    ),
                  onPressed: () => recordPicker(),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: tempDoc.isNotEmpty ? Image.memory(tempDoc, width: 150,): const Text('No Image Selected.', style: TextStyle(color: Colors.white),),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    textStyle: TextStyle(fontSize: 16),
                    primary: Color(0xfff2aa4d),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                    child: Text(buttonText),
                    onPressed: () async{
                        if (ownerName.isNotEmpty && recordType.isNotEmpty && tempDoc.isNotEmpty && buttonText == 'Save'){
                          ownerName = ownerNameController.text;
                          recordType = recordNameController.text;
                          
                          final snackBar = SnackBar(content: Text("Record Added"), backgroundColor: Colors.green,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Record record = Record(recordID: recordIDtoParse.toString(), recordType: recordType, dateStored: dateStored, ownerName: ownerName,  document: tempDoc);
                          DatabaseConnection().insertContact(record);
                          ownerNameController.clear();
                          recordNameController.clear();
                      }
                      else if(ownerName.isNotEmpty && recordType.isNotEmpty && tempDoc.isNotEmpty && buttonText == 'Update'){
                        final snackBar = SnackBar(content: Text("Record Updated"), backgroundColor: Colors.green,);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Record record = Record(recordID: recordIDtoParse.toString(), recordType: recordType, dateStored: dateStored, ownerName: ownerName,  document: tempDoc);
                        DatabaseConnection().updateRecord(record, int.parse(recordID));
                        ownerNameController.clear();
                        recordNameController.clear();
                      }
                    },
                  )
                ],
              ),
            ],
          )
          ),
        ),
      ),
  );
}


