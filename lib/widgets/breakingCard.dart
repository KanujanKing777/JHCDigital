import 'dart:ffi';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

class BreakingNewsCard extends StatefulWidget {
  String urls = "";
  String images = "";
  String txts = "";
  BreakingNewsCard(
      {required this.urls, required this.images, required this.txts});
  @override
  State<BreakingNewsCard> createState() =>
      _BreakingNewsCardState(urls: urls, images: images, txts: txts);
}

class _BreakingNewsCardState extends State<BreakingNewsCard> {
  String urls = "";
  String images = "";
  String txts = "";
  List<String> bigtext = [""];
  _BreakingNewsCardState(
      {required this.urls, required this.images, required this.txts});
  
  @override
  Widget build(BuildContext context) {
    bigtext = txts.split(',');
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 66,
                          backgroundColor: Colors.black,
                          title: Text(
                            bigtext[0],
                            style: TextStyle(color: Colors.white),
                          )),
                      body: SingleChildScrollView(
                        
                        
                        child: Column(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRect(
                              
                              child: Image.network(images),),
                            Padding(
                              
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 15, sigmaY: 15),
                                      child: Container(
                                        color: Colors.black.withOpacity(0.1),
                                        child: Center(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 15,),
                                                Container(
                                                  
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(15),
                                                    child: Text(
                                                      

bigtext[1],
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.045,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                    SizedBox(
                                                      
                                                      width: MediaQuery.of(context).size.width * 0.4,child:
                                                    FloatingActionButton(
                                                      backgroundColor: const Color.fromARGB(31, 255, 255, 255),
                                                      splashColor: const Color.fromARGB(31, 255, 255, 255),
                                                      focusColor: const Color.fromARGB(31, 255, 255, 255),
                                                      hoverColor: const Color.fromARGB(31, 255, 255, 255),
                                                    onPressed: () async {
                                                      final Uri _url = Uri.parse('$urls');
                                                      if (!await launchUrl(_url)) {
                                                        throw Exception('Could not launch $_url');
                                                      }
                                                    },
                                                    child: Text(
                                                      "Visit Link",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal),

                                                            
                                                    )),),
                                                    SizedBox(height: MediaQuery.of(context).size.height * 0.35,)
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
      child:Container(
        margin: EdgeInsets.only(
          top:MediaQuery.of(context).size.height * 0.05,
          bottom:MediaQuery.of(context).size.height * 0.009,),
        height: MediaQuery.of(context).size.height * 0.33,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(images),
          ),
          border: Border.all(width: 0)
        ),
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
                "${bigtext[0]}",
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
