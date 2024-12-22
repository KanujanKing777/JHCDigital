import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Sportsmeetadmin extends StatefulWidget {
  const Sportsmeetadmin({Key? key}) : super(key: key);

  @override
  _CricketAdminState createState() => _CricketAdminState();
}

class _CricketAdminState extends State<Sportsmeetadmin> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> Teams = [
    "Winning House",
    "Sabapathy",
    "Sellathurai",
    "Pasupathi",
    "Kaasipillai",
    "Naagalingam"
  ];
  String firstHouse = "Winning House"; // Set as nullable to handle initial state
String secondHouse = "Winning House";
String thirdHouse = "Winning House";
String fourthHouse = "Winning House";
String fifthHouse = "Winning House";
  // Selected value

  DateTime? selectedDate;
  String MatchName = '';
  String description = 'sample';
  String team1logo = '';
  String team2logo = '';
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> addDataToFirestore() async {
    try {
      // Sample data to add
      final data = {
        'title': MatchName,
        'description': description,
        'first': firstHouse,
        'second': secondHouse,
        'third': thirdHouse,
        'fourth': fourthHouse,
        'fifth': fifthHouse,
      };
      DatabaseReference ref1 =
          FirebaseDatabase.instance.ref('Sportsmeet2024/$MatchName');

      await ref1.set(data);
      // Adding data to the Firestore 'exampleCollection'
      await firestore.collection('exampleCollection').add(data);
      print('Data added successfully!');
    } catch (e) {
      print('Error adding data: $e');
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25),
        color: const Color.fromARGB(255, 32, 32, 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Match Name',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    MatchName = value;
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),

                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First",
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: firstHouse,
                              style: TextStyle(color: Colors.black),
                              items: Teams.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  firstHouse = newValue ?? "";
                                });
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                            ),
                          ],
                        ),),
                        Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),

                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Second",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: secondHouse,
                              style: TextStyle(color: Colors.black),
                              items: Teams.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  secondHouse = newValue ?? "";
                                });
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                            ),
                          ],
                        ),),
                        Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Third",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: thirdHouse,
                              style: TextStyle(color: Colors.black),
                              items: Teams.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  thirdHouse = newValue ?? "";
                                });
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                            ),
                          ],
                        ),),
                        Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),

                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fourth",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: fourthHouse,
                              style: TextStyle(color: Colors.black),
                              items: Teams.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  fourthHouse = newValue ?? "";
                                });
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                            ),
                          ],
                        ),),
                        Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),

                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fifth" ,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: fifthHouse,
                              style: TextStyle(color: Colors.black),
                              items: Teams.map((String name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  fifthHouse = newValue ?? "";
                                });
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                            ),
                          ],
                        ),),
              
              
              SizedBox(height: 16),
              
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await addDataToFirestore();
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
