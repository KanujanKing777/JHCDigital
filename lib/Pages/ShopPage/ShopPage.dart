import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:jhc_app/widgets/breakingCard.dart';

final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ShopPage extends StatelessWidget {
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

                return Container(
                  padding: EdgeInsets.all(16.0),  // Increased padding
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF000000), // Pure black
                        Color(0xFF001020), // Dark blue
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 800) {
                              // Desktop Layout
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: prices.length,
                                itemBuilder: (BuildContext context, index) {
                                  return BreakingNewsCard(
                                    urls: prices[index],
                                    images: imgURLs[index],
                                    txts: descriptions[index],
                                    imglist: [imgURLs[index]],
                                  );
                                },
                              );
                            } else {
                              // Mobile Layout
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: prices.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: MediaQuery.of(context).size.height * 0.3,
                                    child: BreakingNewsCard(
                                      urls: prices[index],
                                      images: imgURLs[index],
                                      txts: descriptions[index],
                                      imglist: [imgURLs[index]],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
