import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:jhc_app/Pages/ShopPage/ShopPage.dart';
import 'package:jhc_app/Pages/Info%20Page/infoPage.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:jhc_app/Home/RealHomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JHC App',
      home:  MyHomePage(selectedindex: 0,),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  int selectedindex = 0;
  MyHomePage({required this.selectedindex});
  @override
  State<MyHomePage> createState() => _MyHomePageState(sselectedIndex: selectedindex);
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }
  int sselectedIndex = 0;

  _MyHomePageState({required this.sselectedIndex});
  final homepages = [RealHomePage(), LiveScoreWidgetCricket(parameter: false,), NewsPage(), ShopPage()];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'JHC',
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 19, 24, 26), // Start Color
                          const Color.fromARGB(255, 11, 17, 21),  // End Color
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  iconTheme: IconThemeData(
                    color: Colors.white, // Change the color here
                  ),
                  title: Text(
                    'JHC Sports App',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.0275,
                        color: Colors.white),
                    selectionColor: Colors.white,
                  ),
                  centerTitle: true,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.09,
                  toolbarOpacity: 0.7,
                  titleSpacing: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  )),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      tooltip: 'Info',
                    )
                  ],
                ),
                body: homepages.elementAt(sselectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                    selectedLabelStyle: TextStyle(fontSize: 16,), // Define text style for selected label
                    unselectedLabelStyle: TextStyle(fontSize: 16),    
                    showUnselectedLabels: false,                 
                    backgroundColor: Color.fromARGB(255, 12, 12, 12),
                    unselectedItemColor: Colors.white,
                    currentIndex: sselectedIndex,         
                    elevation: MediaQuery.of(context).size.height * 0.1,
                    fixedColor: const Color.fromARGB(255, 68, 208, 255),
                    type: BottomNavigationBarType.fixed,
                    items:  [
                      BottomNavigationBarItem(
                        label: "Home",
                        icon: Icon(FontAwesomeIcons.house, size:MediaQuery.of(context).size.width * 0.06),
                      ),
                      BottomNavigationBarItem(
                        label: "Sports",
                        icon: Icon(FontAwesomeIcons.basketball, size:MediaQuery.of(context).size.width * 0.06),
                      ),
                      BottomNavigationBarItem(
                        label: "News",
                        icon: Icon(FontAwesomeIcons.newspaper, size:MediaQuery.of(context).size.width * 0.06),
                        activeIcon: Icon(FontAwesomeIcons.solidNewspaper, size:MediaQuery.of(context).size.width * 0.06),
                      ),
                      BottomNavigationBarItem(
                        label: "Shop",
                        icon: Icon(FontAwesomeIcons.shop, size:MediaQuery.of(context).size.width * 0.06),
                      ),
                    ],
                    onTap: (int indexOfItem) {
                      setState(() {
                        sselectedIndex = indexOfItem;
                      });
                    }),
              ),
            ));        
  }
}
