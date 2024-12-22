import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class BasketballAdmin extends StatefulWidget {
  const BasketballAdmin({Key? key}) : super(key: key);

  @override
  _CricketAdminState createState() => _CricketAdminState();
}

class _CricketAdminState extends State<BasketballAdmin> {
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
Future<void> _selectDatebb(BuildContext context) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),
  );

  if (picked != null) {
    setState(() {
      selectedDateBB = picked;
    });
  }
}

  
  @override
  Widget build(BuildContext context) {

    return Container(
            height:200,
            width: double.infinity,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(25),
            
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 11, 86, 147),
              border: Border.all(color: Colors.black, width: 0),
              borderRadius: BorderRadius.circular(0),
            ),
            transform: Matrix4.rotationZ(0),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Container(
                     color: Colors.white,
                     child: Row(
                     
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('  New Match : ', style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04),),
                      Switch(
                        value: firstTime,
                        onChanged: (value) {
                          setState(() {
                            firstTime = value;
                          });
                        },
                      ),
                    ],
                  ),
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Match Name',
                    ),
                    onChanged: (value){
                      setState(() {
                        MatchNameBB = value;
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    
                    controller: TextEditingController(text: selectedDate.toLocal().toString().split(' ')[0]),
                    readOnly: true,
                    onTap: () {
                      _selectDatebb(context);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Date',
                    ),
                  ),
                  SizedBox(height:16),
                  
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Team A',
                    ),
                    onChanged: (value){
                      setState(() {
                        Team1 = value;
                        normals[0] = value;
                        ShootingTeam = value;
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Team B',
                    ),
                    onChanged: (value){
                      setState(() {
                        Team2 = value;
                        normals[1] = value;
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Points',
                    ),
                    onChanged: (value){
                      setState(() {
                        points = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Shooter',
                    ),
                    onChanged: (value){
                      setState(() {
                        Shooter = value;
                      });
                    },
                  ),
                  SizedBox(height:16),

                  Container(
                    margin:EdgeInsets.all(0),
                    padding:EdgeInsets.all(5),
                    color:Colors.white,
                    width:360,
                    child:  DropdownButton<String>(
                      value: normals.first, // Initial selected value
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                        ShootingTeam = newValue.toString();
                      },
                      items: normals.map((team) => DropdownMenuItem<String>(
                                value: team,
                                child: Text(team),
                      )).toList(),
                    ),
                  ),
                  SizedBox(height:16),

                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Fouls',
                    ),
                    onChanged: (value){
                      setState(() {
                        Fouls = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: '$Team1 logo URL',
                    ),
                    onChanged: (value){
                      setState(() {
                        team1logo = value;
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: '$Team2 logo URL',
                    ),
                    onChanged: (value){
                      setState(() {
                        team2logo = value;
                      });
                    },
                  ),

                  SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.bottomRight,
                    child:FloatingActionButton(    
                      backgroundColor: Color.fromARGB(255, 3, 44, 65),
                      onPressed: () {
                        // Handle click for Tab 1, Button 1
                        showRecordsSavedAlert(context);
                        createUser("BasketBall");
                      },
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                  )
                  
                  
                ],
              ),
            ),
          
          );

  }
}