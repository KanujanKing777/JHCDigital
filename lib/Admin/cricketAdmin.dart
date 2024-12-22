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

  File? _team1logo;
  File? _team2logo;
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
  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _team1logo = File(pickedFile.path);
      });
      uploadImage(_team1logo, Team1);

    }
  }

  Future<void> _getImage2() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _team2logo = File(pickedFile.path);
      });
      uploadImage(_team2logo, Team2);
    }
  }

 Future<String> uploadImage(File?imageFile, String team) async {
  try {
    if(imageFile != null){
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${imageFile.path.split('/').last}');

      await imageRef.putFile(imageFile);
      final downloadURL = await imageRef.getDownloadURL();

      return downloadURL;
    }
    else{
      return " ";
    }
  } catch (e) {
    print('Error uploading image: $e');
    return "akdfj";
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
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  New Match : ',
                    style: TextStyle(
                        color: Colors.black,
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
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Match Name',
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
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Date',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Batting Team',
              ),
              onChanged: (value) {
                setState(() {
                  Team1 = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Balling Team',
              ),
              onChanged: (value) {
                setState(() {
                  Team2 = value;
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
                hintText: 'Over',
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
                color: Colors.white,
                width: 360,
                child: Row(
                  children: [
                    Text("Ball"),
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
                          child: Text(" ${number}"),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Batter',
              ),
              onChanged: (value) {
                setState(() {
                  Batter = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Baller',
              ),
              onChanged: (value) {
                setState(() {
                  Baller = value;
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
                hintText: 'Runs',
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
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Extras',
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
              padding: EdgeInsets.all(5),
              color: Colors.white,
              width: 360,
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
                    child: Text(item),
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
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: '$Wicket by',
                ),
                onChanged: (value) {
                  setState(() {
                    OutBy = value;
                  });
                },
              ),
              SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: '$Team1 logo URL',
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
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: '$Team2 logo URL',
              ),
              onChanged: (value) {
                setState(() {
                  team2logo = value;
                });
              },
            ),
            SizedBox(
              height: 16,
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
                child: Icon(
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
