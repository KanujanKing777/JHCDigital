import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jhc_app/Pages/ScorePage/extendedScore.dart';
import 'package:jhc_app/Pages/ScorePage/extendedScoreBB.dart';
import 'package:jhc_app/widgets/menus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_lib;

final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');

DatabaseReference refSports = FirebaseDatabase.instance.ref('Sports/');


bool isMoreInfo = false;

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color? iconColor;
  const PageData(
      {this.title,
      this.icon,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.iconColor});
}

class LiveScoreWidgetCricket extends StatefulWidget {
  bool parameter = false;

  LiveScoreWidgetCricket({
    required this.parameter
  });
  
  @override
  State<LiveScoreWidgetCricket> createState() => _LiveScoreWidgetCricket(parameter:parameter);
}

int currentPage = 0;

class _LiveScoreWidgetCricket extends State<LiveScoreWidgetCricket> {
  bool parameter = false;
  _LiveScoreWidgetCricket({required this.parameter});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: refSports.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.snapshot.value != null) {
          // Assuming your data is stored in the 'value' property
          final data = snapshot.data!.snapshot.value;
          final screenHeight = MediaQuery.of(context).size.height;

          final chooseLanguage =
              ChooseLanguage(); // Create an instance of ChooseLanguage
          final selectedIndexes = chooseLanguage.getSelectedIndex();

          // Convert DataSnapshot to JSON
          String jsonData = jsonEncode(data);
          Map<String, dynamic> originalLiveScore = json.decode(jsonData);
          Map<String, dynamic> liveScore = originalLiveScore['Cricket'];

          List<int> totalWicketTeam1 = [];
          List<int> totalWicketTeam2 = [];
          List<int> totalRunsTeam1 = [];
          List<int> totalRunsTeam2 = [];
          List<String> overpointball = [];
          List<String> overpointball1 = [];
          List<String> overpointball2 = [];
          List<String> Batter = [];
          List<String> Baller = [];
          List<String> Team1 = [];
          List<String> Team2 = [];
          List<String> Team1Logo = [];
          List<String> Team2Logo = [];
          List<String> MatchName = [];
          List<String> MatchType = [];
          String newLastOverKey = "";
          String lastballkey = "";
          int i = 0;
          int match = 0;
          List<String> Team1Points = [];
          List<String> Team2Points = [];
          List<String> Team1Shooters = [];
          List<String> Team2Shooters = [];
          List<String> imgPathList = [];
          String imgpath = "assets/images/tennis.jpg";
          String _getimgpath() {
            return imgPathList[currentPage];
          }

          if (selectedIndexes.contains(1)) {
            liveScore.forEach((key, value) {
              MatchName.add(key);
              MatchType.add("Cricket");
              String currentBattingTeam = liveScore[key]['Details']['Team A'];
              Team1Logo.add(liveScore[key]['Details']['team1logo']);
              Team2Logo.add(liveScore[key]['Details']['team2logo']);

              liveScore[key]['Stats'].forEach((key2, value2) {
                if (i == 0) {
                  Map<String, dynamic> liveScoreTeam1 =
                      liveScore[key]['Stats'][key2];
                  Team1.add(key2);
                  int totalWicketsteam1 = 0;
                  liveScoreTeam1.forEach((over, balls) {
                    balls.forEach((ball, details) {
                      // Check if the wicket status is "out"
                      if (details['wicket'] != 'NotOut') {
                        totalWicketsteam1++;
                      }
                    });
                  });
                  totalWicketTeam1.add(totalWicketsteam1);
                  int totalRunsteam1 = 0;
                  liveScoreTeam1.forEach((over, balls) {
                    balls.forEach((ball, details) {
                      if (details is Map<String, dynamic> &&
                          details.containsKey('runs')) {
                        totalRunsteam1 += details['runs'] as int;
                      }
                    });
                  });
                  totalRunsTeam1.add(totalRunsteam1);

                  List<String> overKeys1 = liveScoreTeam1.keys.toList();
                  int compareOver(String a, String b) {
                    int numA = int.parse(a.substring(4));
                    int numB = int.parse(b.substring(4));
                    return numA.compareTo(numB);
                  }

                  overKeys1.sort(compareOver);
                  String lastOverKey =
                      overKeys1.isNotEmpty ? overKeys1.last : '';
                  newLastOverKey = lastOverKey.substring(4);

                  Map<String, dynamic> lastOverData =
                      liveScoreTeam1[lastOverKey];

                  List<String> ballKeys = lastOverData.keys.toList();
                  ballKeys.sort(compareOver);

                  String lastBallKey =
                      overKeys1.isNotEmpty ? ballKeys.last : '';
                  lastballkey = lastBallKey.substring(4);

                  if (lastballkey == '6') {
                    overpointball1.add(newLastOverKey);
                  } else {
                    int newLastOverKeyint = int.parse(newLastOverKey);
                    newLastOverKeyint = newLastOverKeyint - 1;
                    newLastOverKey = newLastOverKeyint.toString();
                    overpointball1.add(newLastOverKey + '.' + lastballkey);
                  }
                  Map<String, dynamic> lastBallData = lastOverData[lastBallKey];
                  if (currentBattingTeam == key2) {
                    Batter.add(lastBallData["batter"]);
                    Baller.add(lastBallData["baller"]);
                  }
                  i = i + 1;
                } else {
                  Team2.add(key2);
                  Map<String, dynamic> liveScoreTeam2 =
                      liveScore[key]['Stats'][key2];
                  int totalWicketsteam2 = 0;
                  liveScoreTeam2.forEach((over, balls) {
                    balls.forEach((ball, details) {
                      // Check if the wicket status is "out"
                      if (details['wicket'] != 'NotOut') {
                        totalWicketsteam2++;
                      }
                    });
                  });
                  totalWicketTeam2.add(totalWicketsteam2);

                  int totalRunsteam2 = 0;
                  liveScoreTeam2.forEach((over, balls) {
                    balls.forEach((ball, details) {
                      if (details is Map<String, dynamic> &&
                          details.containsKey('runs')) {
                        totalRunsteam2 += details['runs'] as int;
                      }
                    });
                  });
                  totalRunsTeam2.add(totalRunsteam2);

                  List<String> overKeys = liveScoreTeam2.keys.toList();
                  int compareOver(String a, String b) {
                    int numA = int.parse(a.substring(4));
                    int numB = int.parse(b.substring(4));
                    return numA.compareTo(numB);
                  }

                  overKeys.sort(compareOver);
                  String lastOverKey = overKeys.isNotEmpty ? overKeys.last : '';
                  newLastOverKey = lastOverKey.substring(4);
                  Map<String, dynamic> lastOverData =
                      liveScoreTeam2[lastOverKey];

                  List<String> ballKeys = lastOverData.keys.toList();
                  ballKeys.sort(compareOver);

                  String lastBallKey = overKeys.isNotEmpty ? ballKeys.last : '';
                  lastballkey = lastBallKey.substring(4);
                  Map<String, dynamic> lastBallData = lastOverData[lastBallKey];
                  if (currentBattingTeam == key2) {
                    Batter.add(lastBallData["batter"]);
                    Baller.add(lastBallData["baller"]);
                  }
                  if (lastballkey == '6') {
                    overpointball2.add(newLastOverKey);
                  } else {
                    int newLastOverKeyint = int.parse(newLastOverKey);
                    newLastOverKeyint = newLastOverKeyint - 1;
                    newLastOverKey = newLastOverKeyint.toString();
                    overpointball2.add(newLastOverKey + '.' + lastballkey);
                  }
                  i = 0;
                }
              });
              match = match + 1;
              String a =
                  "${totalRunsTeam1.last}/${totalWicketTeam1.last}(${(overpointball1.last == "0.1") ? 0 : overpointball1.last})";
              Team1Points.add(a);
              String b =
                  "${totalRunsTeam2.last}/${totalWicketTeam2.last}(${(overpointball2.last == "0.1") ? 0 : overpointball2.last})";
              Team2Points.add(b);
            });
          }
          try {
            if (selectedIndexes.contains(2)) {
              liveScore = originalLiveScore['BasketBall'];
              int fun = 0;
              liveScore.forEach((key, value) {
                fun = fun + 1;
                match = match + 1;
                MatchName.add(key.toString());
                MatchType.add("BasketBall");
                Team1.add(liveScore[key]['Details']['Team A']);
                Team2.add(liveScore[key]['Details']['Team B']);
                Team1Logo.add(liveScore[key]['Details']['Team1logo']);
                Team2Logo.add(liveScore[key]['Details']['Team2logo']);
                Team2Points.add("0");
                Map<String, dynamic> loosu = liveScore[key]['Stats'];
                liveScore[key]['Stats'].forEach((key2, value2) {
                  if (liveScore[key]['Stats'][key2]['Shooting Team'] ==
                      Team1.last) {
                    Team1Points.add(
                        liveScore[key]['Stats'][key2]['Points'].toString());
                    Team1Shooters.add(
                        liveScore[key]['Stats'][key2]['Shooter'].toString());
                  } else {
                    Team2Points.add(
                        liveScore[key]['Stats'][key2]['Points'].toString());
                    Team2Shooters.add(
                        liveScore[key]['Stats'][key2]['Shooter'].toString());
                  }
                });
              });
              overpointball.add("fun");
              overpointball1.add("fun");
              overpointball2.add("fun");
              totalRunsTeam1.add(0);
              totalRunsTeam2.add(0);
            }
          } catch (error) {
            print(error);
          }
          for (int i = 0; i < match; i++) {
            if (MatchType[i] == "Cricket") {
              imgPathList.add("assets/images/gradient5.jpg");
            } else if (MatchType[i] == "BasketBall") {
              imgPathList.add("assets/images/gradient5.jpg");
            } else {
              imgPathList.add("assets/images/gradient5.jpg");
            }
          }
          final pagees = [];
          for (int i = 0; i < match; i++) {
            final a = PageData(
              icon: null,
              title: MatchName[i],
              bgColor: Colors.white,
              textColor: Colors.white,
            );
            pagees.add(a);
          }
          final a = PageData(
            title: " ",
            bgColor: Color(0xff3b1791),
            textColor: Colors.white,
          );
          return (parameter== false)?SingleChildScrollView(
  child: Container(
    padding: EdgeInsets.all(0),
    margin: EdgeInsets.all(0),
    decoration: (parameter == false)
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000000), // Pure black
                                Color(0xFF001020), // Pure black

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )
        : BoxDecoration(color: Colors.black),
    child: Column(
      mainAxisAlignment: (parameter == false)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true, // Add shrinkWrap property
          physics: ScrollPhysics(), // Disable scrolling
          itemCount: match,
          itemBuilder: (context, index) {
            imgpath = imgPathList[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (MatchType[index] == "Cricket")
                        ? SecondPage(
                            eTotalScoreTeam1: Team1Points[index],
                            eTotalScoreTeam2: Team2Points[index],
                            eTeam1: Team1[index],
                            eTeam2: Team2[index],
                            liveScoreE: jsonData,
                            matchName: MatchName[index],
                            eTeam1Logo: Team1Logo[index],
                            eTeam2Logo: Team2Logo[index],
                            eoverpointball1: overpointball1[index],
                            eoverpointball2: overpointball2[index],
                            etotalRunsTeam1: totalRunsTeam1[index],
                            etotalRunsTeam2: totalRunsTeam2[index],
                          )
                        : BBMatchPage(
                            eTeam1: Team1[index],
                            eTeam2: Team2[index],
                            eTeam1Logo: Team1Logo[index],
                            eTeam2Logo: Team2Logo[index],
                            liveScoreE: jsonData,
                            matchName: MatchName[index],
                            eTotalScoreTeam1: Team1Points[index],
                            eTotalScoreTeam2: Team2Points[index],
                          ),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(100, 32, 1, 75)
                                .withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 15,
                            sigmaY: 15,
                          ),
                          child: Container(
                            color: Colors.white.withOpacity(0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(0),
                                  child: (index == match)
                                      ? Text(
                                          "${MatchName[index]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      : Text(
                                          "${MatchName[index][0].toUpperCase()}${MatchName[index].substring(1)}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      (MatchName[index] == "You're all set")
                                          ? SizedBox(
                                              height: 1,
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Text(
                                                  "${Team1[index].toUpperCase()}  ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                  ),
                                                ),
                                                Text(
                                                  "${Team2[index].toUpperCase()}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: Team1Logo[index],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                ),
                                                CachedNetworkImage(
                                                  imageUrl: Team2Logo[index],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                )
                                              ],
                                            ),
                                     Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Text(
                                                  "${Team1Points[index]} ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'sans-serif',
                                                      fontSize: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.06),
                                                ),
                                                Text(
                                                  " ${Team2Points[index]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'sans-serif',
                                                      fontSize: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.06),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.035,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  ),
)
:carousel_lib.CarouselSlider.builder(   
                itemCount: match,    
                itemBuilder: (context, index, id) {
                  imgpath = imgPathList[index];
                  return InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      enableFeedback: false,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (MatchType[index] ==
                                      "Cricket")
                                  ? SecondPage(
                                      eTotalScoreTeam1: Team1Points[index],
                                      eTotalScoreTeam2: Team2Points[index],
                                      eTeam1: Team1[index],
                                      eTeam2: Team2[index],
                                      liveScoreE: jsonData,
                                      matchName: MatchName[index],
                                      eTeam1Logo: Team1Logo[index],
                                      eTeam2Logo: Team2Logo[index],
                                      eoverpointball1: overpointball1[index],
                                      eoverpointball2: overpointball2[index],
                                      etotalRunsTeam1: totalRunsTeam1[index],
                                      etotalRunsTeam2: totalRunsTeam2[index],
                                    )
                                  : BBMatchPage(
                                      eTeam1: Team1[index],
                                      eTeam2: Team2[index],
                                      eTeam1Logo: Team1Logo[index],
                                      eTeam2Logo: Team2Logo[index],
                                      liveScoreE: jsonData,
                                      matchName: MatchName[index],
                                      eTotalScoreTeam1: Team1Points[index],
                                      eTotalScoreTeam2: Team2Points[index],
                                    ),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(100, 32, 1, 75)
                                          .withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15, sigmaY: 15),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.1),
                                      child: Center(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                
                                                width: double.infinity,
                                                padding: EdgeInsets.all(12),
                                                margin: EdgeInsets.all(0),
                                                child: (index == match)
                                                    ? Text(
                                                        "${MatchName[index]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.07,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    : Text(
                                                        "${MatchName[index][0].toUpperCase()}${MatchName[index].substring(1)}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.07,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: <Widget>[
                                                    (MatchName[index] ==
                                                            "You're all set")
                                                        ? SizedBox(
                                                            height: 1,
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                "${Team1[index].toUpperCase()}  ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.06,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${Team2[index].toUpperCase()}",
                                                                
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.06,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    (MatchName[index] ==
                                                            "You're all set")
                                                        ? Image.asset(
                                                            "assets/images/repaair.png",
                                                            width: 185,
                                                            height: 145)
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              CachedNetworkImage(
                                                                  imageUrl:
                                                                      Team1Logo[
                                                                          index],
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2),
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                    Team2Logo[
                                                                        index],
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                              )
                                                            ],
                                                          ),
                                                    (MatchName[index] ==
                                                            "You're all set")
                                                        ? SizedBox(
                                                            height: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.06,
                                                            width: 1,
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                "${Team1Points[index]} ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'sans-serif',
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.06),
                                                              ),
                                                              Text(
                                                                " ${Team2Points[index]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'sans-serif',
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.06),
                                                              ),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.04,)
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ));
                },
                options: carousel_lib.CarouselOptions(
                    aspectRatio: 16 / 16,
                    height: screenHeight*0.35,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    enlargeCenterPage: true,
                  )
              );
        } else if (snapshot.hasError) {
          return Text('Error from snapshot: ${snapshot.error}');
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 150,
            ),
          ); // Loading indicator while waiting for data
        }
      },
    );
  }
}

