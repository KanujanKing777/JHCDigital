import 'dart:ui';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class ViewPageSportsmeet extends StatelessWidget {
  final String txts; // Title text for AppBar
  final String images; // URL of the image
  final String first; // Content text
    final String second; // Content text
  final String third; // Content text
  final String fourth; // Content text
  final String fifth; // Content text
final String description;
  final String urls; // URL for the button

  // Constructor with required parameters
  ViewPageSportsmeet({
    required this.txts,
    required this.images,
    required this.first,
    required this.description,
        required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,

    required this.urls,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        backgroundColor: Colors.black,
        title: Text(
          txts,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRect(
              child: Image.network(images),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      color: Colors.black.withOpacity(0.1),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: Text(
                                description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                              child: Text(
                                "1st Place: ${first}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "2nd Place: ${second}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "3rd Place: ${third}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "4th Place: ${fourth}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, bottom: 15),
                              child: Text(
                                "5th Place: ${fifth}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
