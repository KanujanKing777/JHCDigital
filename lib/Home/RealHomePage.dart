import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jhc_app/Home/ShopPageHome.dart';
import 'package:jhc_app/Home/liveCricket.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Home/NewsPageHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealHomePage extends StatefulWidget {
  @override
  _RealHomePageState createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  String? lastShownId; // To track the last shown document

  @override
  void initState() {
    super.initState();
    listenForUpdates();
  }

  void listenForUpdates() {
    FirebaseFirestore.instance
        .collection("Cricket") // Replace with actual Firestore collection
        .orderBy("Date", descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        String docId = doc.id;
        String MatchName = doc["MatchName"];
        String TeamA = doc["Team A"];
        String TeamB = doc["Team B"];
        String Team1logo = doc["team1logo"];
        String Team2logo = doc["team2logo"];
        String Team1score = doc["team1score"];
        String Team2score = doc["team2score"];
        int Win = doc["win"];

        if (lastShownId != docId) {
          setState(() {
            lastShownId = docId;
          });

          if (mounted && Win == 0) {

            showPopup(context, MatchName, TeamA, TeamB, Team1logo, Team2logo, Team1score, Team2score);
          }
        }
      }
    });
  }

  void showPopup(BuildContext context, String Matchname, String TeamA, String TeamB, String Team1logo, String Team2logo, String Team1score, String Team2score) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: 
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  Matchname.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),                                               
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: Team1logo,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    TeamA.toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "$Team1score - $Team2score",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: Team2logo,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    TeamB.toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        double titleFontSize = screenHeight * 0.03;

        return Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF000000), Color(0xFF001020)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Recent Events", MyHomePage(selectedindex: 2), titleFontSize),
                SizedBox(height: screenHeight * 0.02),
                NewsPageHome(),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Recent Sports", MyHomePage(selectedindex: 1), titleFontSize),
                LiveScoreWidgetCricket(parameter: true),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Shop", MyHomePage(selectedindex: 3), titleFontSize),
                SizedBox(height: screenHeight * 0.02),
                ShopPageHome(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Widget page, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.arrow_outward_outlined, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        ),
      ],
    );
  }
}
