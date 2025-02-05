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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
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
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  late int _selectedIndex; // Use a local variable for state management
  List<Widget> _pages = [];  // Initialize this here
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _loadInterstitialAd();
    // Initialize _pages here to ensure _showInterstitialAd is available
    _pages = [
      RealHomePage(ads: _showInterstitialAd),
      SportsPage(ad: _showInterstitialAd,),
      NewsPage(),
      ShopPage(),
    ];
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-2073950926113955/7777522475", // Test Ad Unit
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            _interstitialAd = ad;
            _isAdLoaded = true;
          });

          // Handle when ad is closed
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _loadInterstitialAd(); // Reload after dismissal
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              print('Ad failed to show: $error');
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isAdLoaded = false;
    } else {
      print("Ad is not ready yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(builder: (context) =>  InfoPage()),
              );
            },
            icon: const Icon(Icons.info, color: Colors.white),
            tooltip: 'Info',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        showUnselectedLabels: false,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        elevation: MediaQuery.of(context).size.height * 0.1,
        fixedColor: const Color.fromARGB(255, 68, 208, 255),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(FontAwesomeIcons.house, size: MediaQuery.of(context).size.width * 0.06),
          ),
          BottomNavigationBarItem(
            label: "Sports",
            icon: Icon(FontAwesomeIcons.basketball, size: MediaQuery.of(context).size.width * 0.06),
          ),
          BottomNavigationBarItem(
            label: "News",
            icon: Icon(FontAwesomeIcons.newspaper, size: MediaQuery.of(context).size.width * 0.06),
            activeIcon: Icon(FontAwesomeIcons.solidNewspaper, size: MediaQuery.of(context).size.width * 0.06),
          ),
          BottomNavigationBarItem(
            label: "Shop",
            icon: Icon(FontAwesomeIcons.shop, size: MediaQuery.of(context).size.width * 0.06),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
