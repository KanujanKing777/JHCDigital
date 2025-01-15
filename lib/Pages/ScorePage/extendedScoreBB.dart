import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jhc_app/widgets/ImageProvider.dart';
import 'package:jhc_app/Pages/ScorePage/extendedScoreBasketBall.dart';

class BBMatchPage extends StatelessWidget {
  String eTeam1;
  String eTeam2;
  String liveScoreE;
  String matchName = "";
  String eTotalScoreTeam1;
  String eTotalScoreTeam2;
  String eTeam1Logo;
  String eTeam2Logo;

  bool fun = false;

  BBMatchPage({
      required this.eTeam1,
      required this.eTeam2,
      required this.liveScoreE,
      required this.matchName,
      required this.eTotalScoreTeam1,
      required this.eTotalScoreTeam2,
      required this.eTeam1Logo,
      required this.eTeam2Logo,
});

  @override
  Widget build(BuildContext context) {
          Map<String, dynamic> originalLiveScore = json.decode(liveScoreE);
          Map<String, dynamic> liveScore = originalLiveScore['Cricket'];

          List<String> Team1Points = [];
          List<String> Team2Points = [];
          List<String> Team1Shooters = [];
          List<String> Team2Shooters = [];
    liveScore = originalLiveScore['BasketBall'];
              int fun = 0;
              liveScore.forEach((key, value) {
                fun = fun + 1;
                Team1Points.add("0");
                Team2Points.add("0");
                liveScore[key]['Stats'].forEach((key2, value2) {
                  if (liveScore[key]['Stats'][key2]['Shooting Team'] ==
                      Teams.first) {
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
    Map<String, dynamic> liveScoreE2 = json.decode(liveScoreE);
    Map<String, dynamic> liveScoreE3 = liveScoreE2['BasketBall'][matchName]['Stats'];

    List<String> ShootersTeam1 = [];
    Map<String,num> ShootersPointsTeam1 = {};
    Map<String, num> FoulsTeam1 = {};
    List<String> ShootersTeam2 = [];
    Map<String,num> ShootersPointsTeam2 = {};
    Map<String, num> FoulsTeam2 = {};
    liveScoreE3.forEach((key, balls) {
        if(liveScoreE3[key]['Shooting Team'] == eTeam1){
          ShootersTeam1.add(liveScoreE3[key]['Shooter']);
          ShootersPointsTeam1[liveScoreE3[key]['Shooter']] = (ShootersPointsTeam1[liveScoreE3[key]['Shooter']] ?? 0) + (liveScoreE3[key]['Points']);
          FoulsTeam1[liveScoreE3[key]['Shooter']] = (FoulsTeam1[liveScoreE3[key]['Shooter']] ?? 0) + (liveScoreE3[key]['Fouls']);
        }
        else if(liveScoreE3[key]['Shooting Team'] == eTeam2){
          ShootersTeam2.add(liveScoreE3[key]['Shooter']);
          ShootersPointsTeam2[liveScoreE3[key]['Shooter']] = (ShootersPointsTeam1[liveScoreE3[key]['Shooter']] ?? 0) + (liveScoreE3[key]['Points']);
          FoulsTeam2[liveScoreE3[key]['Shooter']] = (FoulsTeam2[liveScoreE3[key]['Shooter']] ?? 0) + (liveScoreE3[key]['Fouls']);

        }
    },
    );
    
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text("$matchName",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              elevation: 0.0,
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              bottom: 
              TabBar(
                labelPadding: EdgeInsets.only(left: 4.0, right: 4),
                indicatorWeight:1.0,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                
                tabs: [
                  Tab(
                    text: "SUMMARY",
                  ),
                  
                  Tab(
                    text: "SCORECARD",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              children: <Widget>[
                Container(
                margin: EdgeInsets.all(0),
                  child:
                SingleChildScrollView(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: 
                      BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: 
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                                "https://t3.ftcdn.net/jpg/01/05/51/40/360_F_105514051_uSAV0YVEVO3gd8D4PiCEZqHkkQJNRX9B.jpg",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 74, 72, 75)
                                      .withOpacity(0.75)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "$eTeam1",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            fontWeight: FontWeight.bold,
                                            ),

                                          
                                      ),
                                      SizedBox(width: 3,),
                                      Text(
                                        "$eTeam2",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(eTeam1Logo, height: 100, width: 100,),
                                      SizedBox(width: 3,),
                                      Image.network(eTeam2Logo, height: 100, width: 100,),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${Team1Points.last}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'sans-serif',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06),
                                      ),
                                      SizedBox(width: 3,),
                                      Text(
                                        "${Team2Points.last}",
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
                          ],
                        ),
                      ),
                      )),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                        padding: EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(200, 20, 21, 24),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text((ShootersTeam1.isEmpty)?" ":"${ShootersTeam1.last}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    )),
                                Text("Last Goal",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    )),
                               
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                        padding: EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(200, 20, 21, 24),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text((ShootersTeam2.isEmpty)?" ":"${ShootersTeam2.last}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    )),
                                Text("Last Goal",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      
                      MyTableWidget(
                        rowCount: ShootersTeam1.length,
                        teamshootersnames: ShootersTeam1,
                        teamshooterspoints: ShootersPointsTeam1,
                        fouls: FoulsTeam1,
                        caption: "Shooters ($eTeam1)"
                      ),
                      MyTableWidget(
                        rowCount: ShootersTeam2.length,
                        teamshootersnames: ShootersTeam2,
                        teamshooterspoints: ShootersPointsTeam2,
                        fouls: FoulsTeam2,
                        caption: "Shooters ($eTeam2)"
                      ),
                      
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
                
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15,),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(200, 20, 21, 24),
                          
                        ),
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 10,),

                                Image.network(
                                    eTeam2Logo,
                                    width: 70,
                                    fit: BoxFit.cover),
                                SizedBox(width: 15,),
                                Text("$eTeam2",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ),
                            Row(
                              children: [
                                Text("$eTotalScoreTeam1",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                SizedBox(width: 8,)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(200, 20, 21, 24),
                          
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width:10),
                                Image.network(
                                    eTeam1Logo,
                                    width: 70,
                                    fit: BoxFit.cover),
                                SizedBox(width:15),
                                Text("$eTeam1",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ),
                            Row(
                              children: [
                                Text("$eTotalScoreTeam2",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                SizedBox(width: 8,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  
}
