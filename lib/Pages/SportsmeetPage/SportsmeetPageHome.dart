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
DatabaseReference refSports = FirebaseDatabase.instance.ref('Sportsmeet2024/');

class SportsPageHome extends StatelessWidget {
  Map<String, dynamic> convertMap(Map<Object?, Object?> input) {
  return input.map((key, value) {
    // Ensure key is a String and cast value to dynamic
    return MapEntry(key.toString(), value);
  });
}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: refSports.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.snapshot.value != null) {
          // Assuming your data is stored in the 'value' property
          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final screenHeight = MediaQuery.of(context).size.height;
          final urllists = convertMap(data);

          List<String> urls = [];
          List<String> imgURLs = [];
          List<String> descriptions = [];
          List<String> first = [];
          List<String> second = [];
          List<String> third = [];
          List<String> fourth = [];
          List<String> fifth = [];

          List<String> txts = [];

          urllists.forEach((eventName, eventDetails) {
          //   String eventKey = data!.keys.elementAt(index);
          // Map<String, String> eventDetails = data[eventKey] ?? {};
            txts.add(eventDetails['title']);
            urls.add('1st Place ' + eventDetails['first']);
            imgURLs.add(eventDetails['image']);
            descriptions.add(eventDetails['description']);

            first.add(eventDetails['first']);
            second.add(eventDetails['second']);
            third.add(eventDetails['third']);
            fourth.add(eventDetails['fourth']);
            fifth.add(eventDetails['fifth']);

        
          });

          return 
          carousel_lib.CarouselSlider.builder(
            itemCount: urls.length, 
            itemBuilder: (context, index, id) =>
                      BreakingNewsCard(urls: urls[index],images: imgURLs[index],txts: txts[index], first: first[index], second: second[index], third: third[index], fourth: fourth[index], fifth: fifth[index], description: descriptions[index],), 
            options: carousel_lib.CarouselOptions(
              aspectRatio: 16 / 9,
              height: screenHeight*0.31,
              autoPlay: false,
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
