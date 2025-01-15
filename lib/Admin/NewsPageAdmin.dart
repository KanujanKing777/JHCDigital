import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Admin/shopAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');

class NewsPageAdmin extends StatefulWidget {
  const NewsPageAdmin({Key? key}) : super(key: key);

  @override
  _NewsPageAdmin createState() => _NewsPageAdmin();
}

class _NewsPageAdmin extends State<NewsPageAdmin> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> normals = ["YouTube"];
  int index = 0;
  String url = "";
  List<String> images = [];
  String utube = "";
  String txt = "";
  final TextEditingController _controller1 = TextEditingController();


  void _addString1() {
    if (_controller1.text.isNotEmpty) {
      setState(() {
        images.add(_controller1.text);
        _controller1.clear();
      });
    }
  }
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
                // Close the alert dialog
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 32, 32, 32),
      ),
      child: SingleChildScrollView(
      child:Column(
        children: [
      TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              hintText: "News URL",
                            hintStyle: TextStyle(color: Colors.white)

              ),
          onChanged: (value) {
            setState(() {
              url = value;
            });
          },
          style: TextStyle(color: Colors.white),
        ),
      
      SizedBox(
        height: 15,
      ),
      TextField(
              controller: _controller1,
              
              decoration: InputDecoration(
                labelText: "Image Urls",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addString1(),
                ),
              ),
            ),
      
      SizedBox(
        height: 15,
      ),
      TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              hintText: "Text to be displayed",
              hintStyle: TextStyle(color: Colors.white)
          ),
              
          onChanged: (value) {
            setState(() {
              txt = value;
            });
          },
          style: TextStyle(color: Colors.white),
        ),
      
      SizedBox(
        height: 15,
      ),
     TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              hintText: "Youtube Link",
              hintStyle: TextStyle(color: Colors.white)
          ),
              
          onChanged: (value) {
            setState(() {
              utube = value;
            });
          },
          style: TextStyle(color: Colors.white),
        ),
      
      SizedBox(
        height: 15,
      ),
      FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 3, 44, 65),
          child: Icon(Icons.add),
          onPressed: () async {
            showRecordsSavedAlert(context);

            try {
              // Sample data to add
              final data = {
                'url': url,
                'images': images,
                'text': txt,
                'utube':utube
              };

              // Adding data to the Firestore 'exampleCollection'
              DatabaseReference ref1 =
            FirebaseDatabase.instance.ref('URLs/$txt');

        await ref1.set(data);
              print('Data added successfully!');
            } catch (e) {
              print('Error adding data: $e');
            }
          }),
      SizedBox(
        height: 15,
      )
    ])));
  }
}
