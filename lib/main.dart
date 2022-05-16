import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const frontPage());
}

class frontPage extends StatelessWidget {
  const frontPage({Key? key}) : super(key: key);

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
        ),
      ),
    );
  }
}
