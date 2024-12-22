import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:jhc_app/widgets/breakingCard.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPageHome.dart';
class RealHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF000000), Color(0xFF001020), ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  "Sportsmeet 2024",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_outward_outlined, color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage(selectedindex: 2,))));
                  }
                )
              ],),
              NewsPageHome(),
              SizedBox(height: 30,),
              Row(children: [
                Text(
                  "Recent Events",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_outward_outlined, color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage(selectedindex: 2,))));
                  }
                )
              ],),
              NewsPageHome(),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.all(0),
                child:
              Row(children: [
                Text(
                  "Recent Sports",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_outward_outlined, color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage(selectedindex: 1,))));
                  }
                )
              ],),
              ),
              LiveScoreWidgetCricket(parameter: true,),
            ],
          ),
        ),
      );
  }
}
