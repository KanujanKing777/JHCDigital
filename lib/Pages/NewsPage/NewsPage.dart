import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:jhc_app/Pages/infoPage.dart';
import 'package:jhc_app/widgets/menus.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:jhc_app/Pages/Calendar/calendar.dart';
import 'package:jhc_app/Pages/NewsPage/newNewsPage.dart';
import 'package:jhc_app/widgets/breakingCard.dart';
final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');
DatabaseReference refSports = FirebaseDatabase.instance.ref('URLs/');
final client = true;

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: refSports.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.snapshot.value != null) {
              // Assuming your data is stored in the 'value' property
              final data = snapshot.data!.snapshot.value;
              final screenHeight = MediaQuery.of(context).size.height;
              final screenWidth = MediaQuery.of(context).size.width;

              String jsonData = jsonEncode(data);
              Map<String, dynamic> urllists = json.decode(jsonData);
              List<String> urls = [];
              List<String> imgURLs = [];
              List<String> txts = [];

              urllists.forEach((index, value) {
                String fun = urllists[index]['url'];
                if (!fun.isEmpty) {
                  urls.add(fun);
                }
                String funi = urllists[index]['image'];
                if (!funi.isEmpty) {
                  imgURLs.add(funi);
                }
                String funt = urllists[index]['text'];
                if (!funt.isEmpty) {
                  txts.add(funt);
                }
              });

              return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000000), // Pure black
                                Color(0xFF001020), // Pure black

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: 
              SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: urls.length,
                    itemBuilder: (BuildContext context, index) {
                      return BreakingNewsCard(urls: urls[index], images: imgURLs[index], txts: txts[index]);
                    },
                  )
                ],
              ))
    );
    } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
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
