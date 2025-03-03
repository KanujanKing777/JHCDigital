import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jhc_app/Pages/Info%20Page/infoPage.dart';
import 'package:jhc_app/Pages/ScorePage/Sportspage.dart';
import 'package:jhc_app/Pages/ShopPage/ShopPage.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:jhc_app/Home/RealHomePage.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JHC Digital',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(selectedIndex: 0),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? Container(),
            GlobalVideoListener(),
          ],
        );
      },
    );
  }
}

class GlobalVideoListener extends StatefulWidget {
  @override
  _GlobalVideoListenerState createState() => _GlobalVideoListenerState();
}

class _GlobalVideoListenerState extends State<GlobalVideoListener> {
  bool _showVideo = false;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    _listenToFirestore();
  }

  void _listenToFirestore() {
    FirebaseFirestore.instance
        .collection("apple")
        .doc("fun")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        String? videoId = snapshot.data()?['id'];
        if (videoId != null && videoId.isNotEmpty) {
          if (_youtubeController == null || _youtubeController!.initialVideoId != videoId) {
            _youtubeController = YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                hideControls: true,
                loop: true
              ),
            );
            setState(() {});
          }
        }
        if (snapshot.data()?['show'] == 'yes') {
          setState(() {
            _showVideo = true;
          });
         
        }else if(snapshot.data()?['show'] == 'no'){
          setState(() {
            _showVideo = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showVideo && _youtubeController != null
        ? Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.aspectRatio,
                child:YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: false,
              )),
            ),
          )
        : SizedBox.shrink();
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  final int selectedIndex;
  const MyHomePage({super.key, required this.selectedIndex});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late int _selectedIndex; // Use a local variable for state management
  List<Widget> _pages = [];  // Initialize this here
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    // Initialize _pages here to ensure _showInterstitialAd is available
    _pages = [
      RealHomePage(),
      SportsPage(),
      NewsPage(),
      ShopPage(),
    ];
  }


  @override
  Widget build(BuildContext context) {
  bool isDesktop = MediaQuery.of(context).size.width > 800; // Define breakpoint

  return Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 24, 26), // Start Color
              Color.fromARGB(255, 11, 17, 21),  // End Color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'JHC Digital',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
      toolbarOpacity: 0.7,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          },
          icon: const Icon(Icons.info, color: Colors.white),
          tooltip: 'Info',
        ),
      ],
    ),
    body: Row(
      children: [
        if (isDesktop)
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.black,
            selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 68, 208, 255), size: 32),
            unselectedIconTheme: const IconThemeData(color: Colors.white, size: 28),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.house),
                selectedIcon: Icon(FontAwesomeIcons.house),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.basketball),
                selectedIcon: Icon(FontAwesomeIcons.basketball),
                label: Text("Sports"),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.newspaper),
                selectedIcon: Icon(FontAwesomeIcons.solidNewspaper),
                label: Text("News"),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.shop),
                selectedIcon: Icon(FontAwesomeIcons.shop),
                label: Text("Shop"),
              ),
            ],
          ),

        // Main content area
        Expanded(
          child: _pages[_selectedIndex], // Display selected page
        ),
      ],
    ),

    bottomNavigationBar: isDesktop ? null : _buildBottomNavigationBar(),
  );
}

Widget _buildBottomNavigationBar() {
  return BottomNavigationBar(
    selectedLabelStyle: const TextStyle(fontSize: 16),
    unselectedLabelStyle: const TextStyle(fontSize: 16),
    showUnselectedLabels: false,
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.white,
    currentIndex: _selectedIndex,
    elevation: 10,
    fixedColor: const Color.fromARGB(255, 68, 208, 255),
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        label: "Home",
        icon: Icon(FontAwesomeIcons.house),
      ),
      BottomNavigationBarItem(
        label: "Sports",
        icon: Icon(FontAwesomeIcons.basketball),
      ),
      BottomNavigationBarItem(
        label: "News",
        icon: Icon(FontAwesomeIcons.newspaper),
        activeIcon: Icon(FontAwesomeIcons.solidNewspaper),
      ),
      BottomNavigationBarItem(
        label: "Shop",
        icon: Icon(FontAwesomeIcons.shop),
      ),
    ],
    onTap: (int index) {
      setState(() {
        _selectedIndex = index;
      });
    },
  );
}

}
