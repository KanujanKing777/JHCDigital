import 'package:jhc_app/Pages/SportsmeetPage/SportsmeetViewPage.dart';
import 'package:jhc_app/widgets/interior.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BreakingNewsCard extends StatefulWidget {
  String urls = "";
  List<String>? imglist = [""];
  String images = "";
  String txts = "";
  String? description = "";
  String? first = "";
  String? second = "";
  String? third = "";
  String? fourth = "";
  String? fifth = "";
  String? utube = "";
  BreakingNewsCard(
      {required this.urls,
      required this.images,
      required this.txts,
      this.description,
      this.fifth,
      this.first,
      this.fourth,
      this.second,
      this.third,
      this.imglist,
      this.utube});

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
      fifth: fifth ?? "",
      imglist: imglist ?? [""],
      utube: utube ?? "");
}



class _BreakingNewsCardState extends State<BreakingNewsCard> {
  String urls = "";
  String images = "";
  String txts = "";
  List<String> imglist = [""];
  String description = "";
  String first = "";
  String second = "";
  String third = "";
  String fourth = "";
  String fifth = "";
  String utube = "";
 

  _BreakingNewsCardState(
      {required this.urls,
      required this.images,
      required this.txts,
      required this.description,
      required this.fifth,
      required this.first,
      required this.fourth,
      required this.second,
      required this.third,
      required this.imglist,
      required this.utube});
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
                      builder: (context) => Interior(
                        urls: urls,
                        images: images,
                        txts: txts,
                        description: description,
                        first: first,
                        second: second,
                        third: third,
                        fourth: fourth,
                        fifth: fifth,
                        imglist: imglist,
                        utube:utube
                      )
                      ));
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
