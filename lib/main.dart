import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'archive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
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
        backgroundColor: Colors.black,
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
          backgroundColor: Colors.amberAccent.shade700,
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
              
              //Record record = choose.pickImage(source: ImageSource.gallery) as Record;
              ImagePicker().pickImage(source: ImageSource.gallery).then((chosenImage){
                //Record bytes = chosenImage;
                //uploadScannedRecord(bytes); 
              });
                    
            } 
          }
        ),
      ),
    );
  }
}