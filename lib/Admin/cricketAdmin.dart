import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CricketAdmin extends StatefulWidget {
  const CricketAdmin({Key? key}) : super(key: key);

  @override
  _CricketAdminState createState() => _CricketAdminState();
}

class _CricketAdminState extends State<CricketAdmin> {
  List<String> Teams = [BattingTeam, BallingTeam];
  List<String> team1Players = [];
  List<String> team2Players = [];
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
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

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
            Divider(height: 50,thickness: 2, color: Colors.white,),
            Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  New Match : ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
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
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                border:UnderlineInputBorder(),
                hintText: 'Match Name',
                hintStyle: TextStyle(color: Colors.white)
              ),
              onChanged: (value) {
                setState(() {
                  MatchName = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(
                  text: selectedDate.toLocal().toString().split(' ')[0]),
              style: TextStyle(color: Colors.white),    
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Date',
                                hintStyle: TextStyle(color: Colors.white)

              ),
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Team 1',
                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  BattingTeam = value;
                });
                setState(() {
                  Teams.first = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Team 2',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  BallingTeam = value;
                });
                setState(() {
                  Teams.last = value;
                });
              },
            ),
            SizedBox(height: 16,),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black),
                
                hintText: '${Teams.first} logo URL',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  team1logo = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: '${Teams.last} logo URL',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  team2logo = value;
                });
              },
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: "${Teams.first} Players",
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
                labelText: "${Teams.last} Players",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addString2(),
                ),
              ),
            ),
            Divider(height: 50,thickness: 2, color: Colors.white,),
            Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                width: 360,
                child: Row(
                  children: [
                    Text(" Batting Team", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    DropdownButton<String>(
                      value: BattingTeam,
                      onChanged: (String? newValue) {
                        setState(() {
                          BallingTeam = BattingTeam;
                          BattingTeam = newValue ?? BattingTeam;
                          
                        });
                       
                      },
                      items: Teams.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ),
                          SizedBox(height: 16),

            
          Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(
                  children: [
                    Text(" Bowling Team", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    DropdownButton<String>(
                      value: BallingTeam,
                      onChanged: (String? newValue) {
                        setState(() {
                          BattingTeam = BallingTeam;
                          BallingTeam = newValue ?? BallingTeam;
                        });
                      },
                      items: Teams.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ),
                          SizedBox(height: 16),

            
            
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Over',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  Over = int.parse(value);
                });
              },
            ),
            SizedBox(height: 16),
            Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(
                  children: [
                    Text(" Ball", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    DropdownButton<int>(
                      value: Ball,
                      onChanged: (int? newValue) {
                        setState(() {
                          Ball = newValue ?? 1;
                        });
                      },
                      items: numbers.map((int number) {
                        return DropdownMenuItem<int>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            SizedBox(height: 16),
            SizedBox(height: 16),

            
          Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(
                  children: [
                    Text(" Batter: $Batter  ", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    (BattingTeam == Teams.first)?
                    DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          Batter = newValue ?? Batter;
                          
                        });
                      },
                      items: team1Players.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ):
                    DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          Batter = newValue ?? Batter;
                        });
                      },
                      items: team2Players.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ),
                          SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                
                width: 360,
                child: Row(
                  children: [
                    Text(" Baller: $Baller  ", style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(width: 15,),
                    (BallingTeam == Teams.last)?DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          Baller = newValue ?? Baller;
                        });
                      },
                      items: team2Players.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ):DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          Baller = newValue ?? Baller;
                        });
                      },
                      items: team1Players.map((String number) {
                        return DropdownMenuItem<String>(
                          value: number,
                          child: Text(" ${number}", style: TextStyle(color: Colors.white),),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ),
            
            SizedBox(height: 16),
            
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Runs',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  Runs = num.parse(value);
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                
                hintText: 'Extras',
                                hintStyle: TextStyle(color: Colors.white)

              ),
              onChanged: (value) {
                setState(() {
                  Extras = int.parse(value);
                });
              },
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),              width: 360,
              child: DropdownButton<String>(
                value: Wicket,
                onChanged: (String? newValue) {
                  setState(() {
                    Wicket = newValue ?? '';
                  });
                },
                items: outs.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: TextStyle(color: Colors.white),),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            if (Wicket != "NotOut" && Wicket != "Bowled" && Wicket != "LBW")
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  
                  hintText: '$Wicket by',
                                  hintStyle: TextStyle(color: Colors.white)

                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    OutBy = value;
                  });
                },
              ),
              
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 3, 44, 65),
                onPressed: () {
                  // Handle click for Tab 1, Button 1
                  showRecordsSavedAlert(context);
                  createUser("Cricket");
                },
                child:Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
