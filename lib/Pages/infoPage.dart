import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        title: Text('About Us'),
      ),
      body: Container(
        color: Color.fromARGB(255, 35, 35, 35),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JHC Sports is a Mobile Application developed by the IT Club of Jaffna Hindu College.',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              'It is Developed with the purpose of Digitalizing sports events, and the sports community.',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              'Developers:- Kanujan, Karthikan',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            
            SizedBox(height: 20),
            Text(
              'Contact us :- ITClub@jch.lk',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            Text(
              '©JHC IT Society',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

