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
            showPopup(context, MatchName, TeamA, TeamB, Team1logo, Team2logo,
                Team1score, Team2score);
          }
        }
      }
    });
  }

  void showPopup(
      BuildContext context,
      String Matchname,
      String TeamA,
      String TeamB,
      String Team1logo,
      String Team2logo,
      String Team1score,
      String Team2score) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  width: isDesktop ? screenWidth * 0.5 : screenWidth * 0.9,
                  height: isDesktop
                      ? MediaQuery.of(context).size.height * 0.6
                      : MediaQuery.of(context).size.height * 0.75,
                  margin: EdgeInsets.all(isDesktop ? 25 : 15),
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
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(isDesktop
                                  ? 30
                                  : MediaQuery.of(context).size.height * 0.025),
                              child: Column(
                                children: [
                                  Text(
                                    Matchname.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: isDesktop ? 34 : 29,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: Team1logo,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                    Text(
                                      TeamA.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
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
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: Team2logo,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                    Text(
                                      TeamB.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
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
        bool isDesktop = screenWidth > 800;
        double titleFontSize =
            isDesktop ? screenHeight * 0.04 : screenHeight * 0.03;
        double horizontalPadding =
            isDesktop ? screenWidth * 0.1 : screenWidth * 0.05;

        return Container(
          height: screenHeight,
          padding:
              EdgeInsets.symmetric(vertical: 16, horizontal: horizontalPadding),
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
                _buildSectionHeader(context, "Recent Events",
                    MyHomePage(selectedIndex: 2), titleFontSize),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: isDesktop ? screenWidth * 0.8 : screenWidth,
                  child: NewsPageHome(),
                ),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Recent Sports",
                    MyHomePage(selectedIndex: 1), titleFontSize),
                Container(
                  width: isDesktop ? screenWidth * 0.8 : screenWidth,
                  child: LiveScoreWidgetCricket(parameter: true),
                ),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Shop",
                    MyHomePage(selectedIndex: 3), titleFontSize),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: isDesktop ? screenWidth * 0.8 : screenWidth,
                  child: ShopPageHome(),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, Widget page, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.arrow_outward_outlined,
            color: Colors.white,
            size: fontSize * 1.2,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => page)),
        ),
      ],
    );
  }
}
