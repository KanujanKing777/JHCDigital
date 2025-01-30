import 'package:flutter/material.dart';
import 'package:jhc_app/Home/ShopPageHome.dart';
import 'package:jhc_app/Home/SportsmeetPageHome.dart';
import 'package:jhc_app/Home/liveCricket.dart';
import 'package:jhc_app/Pages/SportsmeetPage/Sportsmeetdedicated.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Home/NewsPageHome.dart';

class RealHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        double titleFontSize = screenWidth * 0.045;

        return Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF000000), Color(0xFF001020)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, "Sportsmeet 2024", Sportsmeetdedicated(), titleFontSize),
                SportsPageHome(),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Recent Events", MyHomePage(selectedindex: 2), titleFontSize),
                NewsPageHome(),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Recent Sports", MyHomePage(selectedindex: 1), titleFontSize),
                LiveScoreWidgetCricket(parameter: true),
                SizedBox(height: screenHeight * 0.05),
                _buildSectionHeader(context, "Shop", MyHomePage(selectedindex: 3), titleFontSize),
                ShopPageHome(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Widget page, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.arrow_outward_outlined, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          ),
        ),
      ],
    );
  }
}
