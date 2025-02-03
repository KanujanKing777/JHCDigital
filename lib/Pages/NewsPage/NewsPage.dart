import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:jhc_app/widgets/breakingCard.dart';

final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class NewsPage extends StatelessWidget {
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
                return Container(
                  padding: EdgeInsets.all(8.0),
                  height: double.infinity,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: urls.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.27,
                              child:
                            BreakingNewsCard(
                               urls: urls[index],
                              images: imgURLs[index],
                              txts: txts[index],
                              imglist: imgURLlists[index],
                              utube: utubes[index],
                            )
                            );
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
