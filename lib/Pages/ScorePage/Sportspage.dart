import 'package:flutter/material.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricketPage.dart';

class SportsPage extends StatefulWidget {
  
  @override
  State<SportsPage> createState() => _SportsPage();
}

class _SportsPage extends State<SportsPage> {
  

  List<String> sports = ["Cricket", "Basketball", "Football"];
  List<String> sportsImages = [
    "images/cricket.jpeg",
    "images/basketball.png",
    "images/football.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child:SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top:15),
        child: Column(
          children: [
            // Header Section
          
            // Animated List of Sports
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sports.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LiveScoreWidgetCricketPage(parameter: sports[index]),
                      ),
                    );
                  },
                  child: AnimatedContainer(
height: MediaQuery.of(context).size.width > 800 
    ? MediaQuery.of(context).size.height * 0.8  // Larger height for desktop
    : MediaQuery.of(context).size.height * 0.4, // Default height for mobile
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: 
                    Stack(
                      children: [
                        // Sports Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20),
                          ),
                          child: Image.asset(
                            sportsImages[index],
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Gradient Overlay with Icon and Text
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        // Sport Name and Icon
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Row(
                            children: [
                              
                              Text(
                                sports[index],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // "Live Now" Badge (Optional)
                        
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
