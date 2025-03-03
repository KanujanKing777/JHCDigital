import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_lib;
import 'package:jhc_app/widgets/breakingCard.dart';

final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ShopPageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('Shop').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final screenHeight = MediaQuery.of(context).size.height;

                List<String> prices = [];
                List<String> imgURLs = [];
                List<String> descriptions = [];

                snapshot.data!.docs.forEach((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  String? price = data['price'];
                  if (price != null && price.isNotEmpty) {
                    prices.add("Rs " + price);
                  }

                  String? image = data['image'];
                  if (image != null && image.isNotEmpty) {
                    imgURLs.add(image);
                  }

                  String? text = data['text'];
                  if (text != null && text.isNotEmpty) {
                    descriptions.add(text);
                  }
                });

                return carousel_lib.CarouselSlider.builder(
                  itemCount: prices.length,
                  itemBuilder: (context, index, id) => BreakingNewsCard(
                    urls: prices[index],
                    images: imgURLs[index],
                    txts: descriptions[index],
                    imglist: [imgURLs[index]],
                  ),
                  options: carousel_lib.CarouselOptions(
                    aspectRatio: 16 / 9,
height: MediaQuery.of(context).size.width > 800 
    ? screenHeight * 0.6  // Larger height for desktop
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
