import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jhc_app/Pages/NewsPage/morefunnews.dart';

class newNewsPage extends StatelessWidget {
  String urlString = "";
  String imgURL = "";
  String txt = "";
  newNewsPage({
    required this.urlString,
    required this.imgURL,
    required this.txt,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      enableFeedback: false,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      
        onTap: () async {
          final Uri _url = Uri.parse('$urlString');
          if (!await launchUrl(_url)) {
            throw Exception('Could not launch $_url');
          }
        },
        child: FacebookPost(userName: "JHC", imageUrl: "$imgURL", postText: txt,)
        /*Container(
            height: MediaQuery.of(context).size.height * 0.5,
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.0101,
                left: MediaQuery.of(context).size.width * 0.0101,
                bottom: MediaQuery.of(context).size.height * 0.07),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                // Container with image (4/5 height)
                Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.all(0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: CachedNetworkImage(
                          imageUrl: imgURL,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      '$txt',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ))*/
      );
  }
}
