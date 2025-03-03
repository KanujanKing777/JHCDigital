import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_lib;
import 'package:jhc_app/widgets/breakingCard.dart';

final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class NewsPageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('News').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final screenHeight = MediaQuery.of(context).size.height;

                List<String> urls = [];
                List<String> imgURLs = [];
                List<List<String>> imgURLlists = [];
                List<String> txts = [];
                List<String> utubes = [];

                snapshot.data!.docs.forEach((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  String? fun = data['url'];
                  if (fun != null && fun.isNotEmpty) {
                    urls.add(fun);
                  }

                  List<dynamic>? images = data['images'];
                  if (images != null && images.isNotEmpty) {
                    imgURLs.add(images[0].toString());
                    imgURLlists.add(images.map((e) => e.toString()).toList());
                  }

                  String? funt = data['text'];
                  if (funt != null && funt.isNotEmpty) {
                    txts.add(funt);
                  }

                  String? utube = data['utube'];
                  if (utube != null && utube.isNotEmpty) {
                    utubes.add(utube);
                  }
                });

                return carousel_lib.CarouselSlider.builder(
                  itemCount: urls.length,
                  itemBuilder: (context, index, id) => BreakingNewsCard(
                    urls: urls[index],
                    images: imgURLs[index],
                    txts: txts[index],
                    imglist: imgURLlists[index],
                    utube: utubes[index],
                  ),
                  options: carousel_lib.CarouselOptions(
                    aspectRatio: 16 / 9,
height: MediaQuery.of(context).size.width > 800 
    ? screenHeight * 0.7  // Larger height for desktop
    : screenHeight * 0.25, // Default height for mobile
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 150,
                  ),
                );
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 150,
            ),
          );
        }
      },
    );
  }
}
