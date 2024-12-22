import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_lib;
import 'package:jhc_app/widgets/breakingCard.dart';


final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');
DatabaseReference refSports = FirebaseDatabase.instance.ref('URLs/');

class NewsPageHome extends StatelessWidget {
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

          return 
          carousel_lib.CarouselSlider.builder(
            itemCount: urls.length, 
            itemBuilder: (context, index, id) =>
                      BreakingNewsCard(urls: urls[index],images: imgURLs[index],txts: txts[index],), 
            options: carousel_lib.CarouselOptions(
              aspectRatio: 16 / 9,
              height: screenHeight*0.31,
              
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            )
                  
    );} else if (snapshot.hasError) {
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
