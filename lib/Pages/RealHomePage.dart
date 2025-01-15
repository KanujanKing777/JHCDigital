import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:jhc_app/Pages/ShopPage/ShopPageHome.dart';
import 'package:jhc_app/Pages/SportsmeetPage/SportsmeetPageHome.dart';
import 'package:jhc_app/widgets/breakingCard.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPageHome.dart';
class RealHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top:16, bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF000000), Color(0xFF001020), ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(width: 10,),
                Text(
                  "Sportsmeet 2024",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],),
              SportsPageHome(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
              Row(children: [
                                SizedBox(width: 10,),

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
              Container(
                margin: EdgeInsets.all(0),
                child:
              Row(children: [
                                SizedBox(width: 10,),

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
              Container(
                margin: EdgeInsets.all(0),
                child:
              Row(
                children: [
                SizedBox(width: 10,),

                Text(
                  "Shop",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_outward_outlined, color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage(selectedindex: 3,))));
                  }
                )
              ],),
              ),
              ShopPageHome(),
            ],
          ),
        ),
      );
  }
}
