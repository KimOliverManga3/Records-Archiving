import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:records_archiving/addDetails.dart';
import 'package:records_archiving/expandedDoc.dart';
import 'archive.dart';
import 'dbCon.dart';
import 'main.dart';
import 'package:intl/intl.dart';


class FrontPageState extends State<FrontPage> {

  @override
  void initState(){
    super.initState();  
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      title: const Text('Archived Documents'),
      foregroundColor: Color(0xff000000),
    ),
    body: Column(
      children: [
          Flexible(
            child: Container(
            padding: EdgeInsets.all(25),
            child: SafeArea(child: FutureBuilder(
            future: DatabaseConnection().getDocument(),
            builder: (BuildContext context, AsyncSnapshot<List<Record>> snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }
                else{
                  if(snapshot.data!.isNotEmpty){                
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return content(snapshot.data![index], context);        
                      });
                  }
                  else{
                    return const Center(
                      child: Text("No Record Found.", 
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                }
              }
            )
          ),
        ),
      ),
    ],
  ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      onPressed: () async {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddDetails(docType: '', ownerName: '', doc: Uint8List.fromList([]), dateStored: DateFormat('yyyy-MM-dd').format(DateTime.now()), recordID: '',))
        );
        setState(() {});
      }
      ),
  );

  Widget content(Record archive, BuildContext context){
    return FocusedMenuHolder(
      menuItems: [
        FocusedMenuItem(
          title: Text("Delete", style: TextStyle(color: Colors.white),),
          trailingIcon: Icon(Icons.delete, color: Colors.white,),
          backgroundColor: Colors.red,
          onPressed: () async {
            await DatabaseConnection().deleteRecord(archive.recordID);
            setState(() {});
          },
        ),
        FocusedMenuItem(
          title: Text("Edit", style: TextStyle(color: Colors.white),),
          trailingIcon: Icon(Icons.edit, color: Colors.white,),
          backgroundColor: Colors.black,
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddDetails(docType: archive.recordType, ownerName: archive.ownerName, doc: archive.document, dateStored: archive.dateStored, recordID: archive.recordID)));
            setState(() {});
          },
        )
      ],
      blurSize: 40.40,
      openWithTap: false,
      onPressed: (){},
      child: Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10)
      ),
        child: Container(
          margin: EdgeInsets.all(6.0),
          padding: EdgeInsets.all(3.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: ListTile(
                  dense: true,
                  leading: SizedBox(
                    width: 90,
                    height: 50,
                    child: Image.memory(archive.document),
                  ),
                  
                  title: Text(    
                    archive.ownerName,
                    style:const TextStyle(fontSize: 18, color: Colors.black, ),
                    ),
                  subtitle: Text('Document Type: ${archive.recordType} \nDate Stored: ${archive.dateStored}'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecordDetails(selectedDocument: archive,)))
                ),
              ), 
            ],
          ),
        ),
    )
  );
    
  }
}