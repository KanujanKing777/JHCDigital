import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Admin/NewsPageAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/'
);

class ShopAdmin extends StatefulWidget {
  const ShopAdmin({Key? key}) : super(key: key);

  @override
  _ShopAdmin createState() => _ShopAdmin();
}

class _ShopAdmin extends State<ShopAdmin> {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String url = "";
  String imageUrl = "";
  String txt = "";
  void showRecordsSavedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Records saved'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          
          mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            

            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: "Price",
                                hintStyle: TextStyle(color: Colors.black)

                ),
                onChanged: (value){
                  setState(() {
                    url = value;
                  });
                },
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: "Product Image URL",
                                hintStyle: TextStyle(color: Colors.black)

                ),
                onChanged: (value){
                  setState(() {
                    imageUrl = value;
                  });
                },
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: "Product Name",
                                hintStyle: TextStyle(color: Colors.black)

                ),
                onChanged: (value){
                  setState(() {
                    txt = value;
                  });
                },
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 15,),
            FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(Icons.add),
              onPressed: ()async{
                showRecordsSavedAlert(context);     
                try {
              // Sample data to add
              final data = {
                'url': url,
                'image': imageUrl,
                'text': txt,
                'timestamp': FieldValue.serverTimestamp(),
              };

              // Adding data to the Firestore 'exampleCollection'
              await firestore.collection('exampleCollection').add(data);
              print('Data added successfully!');
            } catch (e) {
              print('Error adding data: $e');
            }

              }              
            ),
            SizedBox(height: 15,)
          
          
        ]);
   }
}
