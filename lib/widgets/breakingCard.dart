import 'dart:ffi';
import 'package:jhc_app/Pages/SportsmeetPage/SportsmeetViewPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BreakingNewsCard extends StatefulWidget {
  String urls = "";
  String images = "";
  String txts = "";
  String? description = "";
  String? first = "";
  String? second = "";
  String? third = "";
  String? fourth = "";
  String? fifth = "";
  BreakingNewsCard(
      {required this.urls,
      required this.images,
      required this.txts,
      this.description,
      this.fifth,
      this.first,
      this.fourth,
      this.second,
      this.third});

  @override
  State<BreakingNewsCard> createState() => _BreakingNewsCardState(
      urls: urls,
      images: images,
      txts: txts,
      description: description ?? "",
      first: first ?? "",
      second: second ?? "",
      third: third ?? "",
      fourth: fourth ?? "",
      fifth: fifth ?? "");
}

final List<String> imageUrls = [
'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',

];

class _BreakingNewsCardState extends State<BreakingNewsCard> {
  String urls = "";
  String images = "";
  String txts = "";
  String description = "";
  String first = "";
  String second = "";
  String third = "";
  String fourth = "";
  String fifth = "";
  bool isNumeric(String str) {
    if (str.startsWith("Rs")) {
      return true;
    } else {
      return false;
    }
  }

  _BreakingNewsCardState(
      {required this.urls,
      required this.images,
      required this.txts,
      required this.description,
      required this.fifth,
      required this.first,
      required this.fourth,
      required this.second,
      required this.third});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          (urls.startsWith('1st'))
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPageSportsmeet(
                            first: first,
                            second: second,
                            third: third,
                            fourth: fourth,
                            fifth: fifth,
                            txts: txts,
                            images: images,
                            urls: urls,
                            description: description,
                          )))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(
                                toolbarHeight: 66,
                                backgroundColor: Colors.black,
                                title: Text(
                                  txts.split(',')[0],
                                  style: TextStyle(color: Colors.white),
                                )),
                            body: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRect(
                                    child: Image.network(images),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 0, sigmaY: 0),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              child: Center(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          child: Text(
                                                            txts.split(',')[1],
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width *
                                                                    0.045,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )),
                                                      
                                                        GridView.builder(
                                                          shrinkWrap: true, // Ensures the GridView doesn't scroll independently
                                                          physics: NeverScrollableScrollPhysics(), // Disables GridView scrolling
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                1, // Number of columns
                                                            crossAxisSpacing:
                                                                8.0,
                                                            mainAxisSpacing:
                                                                8.0,
                                                          ),
                                                          itemCount:
                                                              imageUrls.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return GestureDetector(
                                                              onTap: () {},
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                child: Image
                                                                    .network(
                                                                  imageUrls[
                                                                      index],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                                                      YoutubePlayer(
                                                        controller:
                                                            YoutubePlayerController(
                                                          initialVideoId:
                                                              "y7T3ax7JPwI",
                                                          flags:
                                                              const YoutubePlayerFlags(
                                                            autoPlay: false,
                                                            mute: false,
                                                            controlsVisibleAtStart: false,
                                                            showLiveFullscreenButton: false,
                                                            hideControls: false
                                                          ),
                                                          
                                                        ),
                                                        showVideoProgressIndicator:
                                                            true,
                                                        onReady: () {
                                                          debugPrint(
                                                              'YouTube Player is ready.');
                                                        },
                                                      ),

                                                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                                                      isNumeric(urls)
                                                          ? SizedBox(
                                                              height: 10,
                                                            )
                                                          : SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              child:
                                                                  FloatingActionButton(
                                                                backgroundColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        31,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                splashColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        31,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                focusColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        31,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                hoverColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        31,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                onPressed:
                                                                    () async {
                                                                  final Uri
                                                                      _url =
                                                                      Uri.parse(
                                                                          '$urls');
                                                                  if (!await launchUrl(
                                                                      _url)) {
                                                                    throw Exception(
                                                                        'Could not launch $_url');
                                                                  }
                                                                },
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "Visit",
                                                                        style: TextStyle(
                                                                            fontSize: MediaQuery.of(context).size.width *
                                                                                0.04,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.01),
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_outward_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )));
        },
        child: Hero(
          tag: images,
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.025,
              bottom: MediaQuery.of(context).size.height * 0.009,
            ),
            height: MediaQuery.of(context).size.height * 0.33,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(images),
                ),
                border: Border.all(width: 0)),
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txts.split(',')[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "$urls",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
