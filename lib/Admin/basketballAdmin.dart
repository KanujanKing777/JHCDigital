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
  String Team1 = "";
  String Team2 = "";
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
final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  List<String> team1Players = [];
  List<String> team2Players = [];

  void _addString1() {
    if (_controller1.text.isNotEmpty) {
      setState(() {
        team1Players.add(_controller1.text);
        _controller1.clear();
      });
    }
  }
  void _addString2() {
    if (_controller2.text.isNotEmpty) {
      setState(() {
        team2Players.add(_controller2.text);
        _controller2.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 32, 32, 32),
      ),
      child: SingleChildScrollView(
              child: Column(

                children: [
                  Container(
                     color: Colors.black,
                     child: Row(
                     
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('  New Match : ', style: TextStyle(
                        color: Colors.white,
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
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Match Name',
                                      hintStyle: TextStyle(color: Colors.white)

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
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Date',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                  ),
                  SizedBox(height:16),
                  
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Team A',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (value){
                      setState(() {
                        BattingTeam = value;
                        normals[0] = value;
                        ShootingTeam = value;
                        Team1 = value;
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Team B',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (value){
                      setState(() {
                        BallingTeam = value;
                        normals[1] = value;
                        Team2 = value;
                      });
                    },
                  ),
                  SizedBox(height:16),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: '${Team1} logo URL',
                                      hintStyle: TextStyle(color: Colors.white)

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
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: '${Team2} logo URL',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (value){
                      setState(() {
                        team2logo = value;
                      });
                    },
                  ),
                                    SizedBox(height: 16),
                                    TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: "${Team1} Players",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addString1(),
                ),
              ),
            ),
            SizedBox(height: 16,),
                  TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText: "${Team2} Players",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addString2(),
                ),
              ),
            ),
            SizedBox(height: 16,),

            Divider(height: 50,thickness: 2, color: Colors.white,),

                  SizedBox(height: 16),

                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Points',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (value){
                      setState(() {
                        points = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(children: [
                    Text(' Shooting Team : ', style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04),),
                  Container(
                    margin:EdgeInsets.all(0),
                    padding:EdgeInsets.all(5),
                    color:Colors.black,
                    width:150,
                    child:  DropdownButton<String>(
                      value: ShootingTeam,
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                        setState(() {
                          ShootingTeam = newValue ?? ShootingTeam;
                          
                        });
                      },
                      items: normals.map((team) => DropdownMenuItem<String>(
                                value: team,
                                child: Text(team, style: TextStyle(color: Colors.white),),
                      )).toList(),
                    ),
                  ),
                  ],),),
                  SizedBox(height: 16,),
                  Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(
                  children: [
                    Text(" Shooter:", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    DropdownButton<String>(
                      value: Shooter,
                      onChanged: (String? newValue) {
                        setState(() {
                          Shooter = newValue ?? Shooter;
                          
                        });
                      },
                      items: [...team1Players, ...team2Players].map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    )
                    
                  ],
                )
              ),
                          SizedBox(height: 16),
                  
                  
                  SizedBox(height:16),

                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: 'Fouls',
                                      hintStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (value){
                      setState(() {
                        Fouls = int.parse(value);
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
            ));

  }
}