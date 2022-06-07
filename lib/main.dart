import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'archive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(mainPage());
}

class mainPage extends StatefulWidget {

  mainPage() : super();

  @override
  frontPage createState() => frontPage();
}

class frontPage extends State<mainPage> {

  int highlightedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          titleTextStyle: GoogleFonts.dekko(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic
            ),
          title: Text('Records Archiving'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            ),
          ],
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Upload',
              icon: Icon(Icons.upload)
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search)
            )
          ],
          currentIndex: highlightedIndex,
          onTap: (int index) {         
            setState(() {
              highlightedIndex = index;
            });
            if(highlightedIndex == 0) {
               selectImage();
              }
            }
          
        ),
      ),
    );
  }
}

Future selectImage() async {
  var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  File tempImageToFile = File(tempImage!.path);
  Uint8List imageToBytes = tempImageToFile.readAsBytesSync();
  Record record = Record(archiveID: 0, scannedRecord: imageToBytes);
  uploadScannedRecord(record);
}