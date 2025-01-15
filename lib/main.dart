import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:jhc_app/Pages/ShopPage/ShopPage.dart';
import 'package:jhc_app/Pages/infoPage.dart';
import 'package:jhc_app/widgets/menus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jhc_app/Admin/cricketAdmin.dart';
import 'package:jhc_app/Admin/basketballAdmin.dart';
import 'package:jhc_app/Admin/admin.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:jhc_app/Pages/Calendar/calendar.dart';
import 'package:jhc_app/Pages/RealHomePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Timer? timer;
final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');

DatabaseReference ref = FirebaseDatabase.instance.ref('Cricket/');
final client = true;
final _firebasemessaging = FirebaseMessaging.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print("hello");
  await _firebasemessaging.requestPermission();
  final FCMtoken = await _firebasemessaging.getToken();
  print('Background message: ${message.messageId}');
  print('Token : $FCMtoken');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String? deviceToken = "";
  @override
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JHC App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(selectedindex: 0,),
    );
  }
}

class MyHomePage extends StatefulWidget {

  int selectedindex = 0;
  MyHomePage({required this.selectedindex});
  @override
  State<MyHomePage> createState() => _MyHomePageState(sselectedIndex: selectedindex);
}

final controller = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Request notification permissions
    _firebaseMessaging.requestPermission().then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("User granted permission");
      } else {
        print("User declined or has not accepted permission");
      }
    });

    // Display a "Hello World" notification a few seconds after the app opens
    Timer(Duration(seconds: 5), _sendHelloWorldNotification);
  }

  void _sendHelloWorldNotification() async {
    // For demonstration purposes, we're printing the notification instead of sending it via an external service
    print("Hello World notification sent");

    // This code assumes integration with a proper notification service for real-world usage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hello World")),
      );
    });
  }

    int sselectedIndex = 0;

  _MyHomePageState({required this.sselectedIndex});
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectDatebb(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDateBB = picked;
      });
    }
  }

  final homepages = [RealHomePage(), LiveScoreWidgetCricket(parameter: false,), NewsPage(), ShopPage()];
  String OOO = "";
  
  @override
  Widget build(BuildContext context) {
    return client
        ? MaterialApp(
            title: 'JHC',
            theme: ThemeData.dark(),
            supportedLocales: {const Locale('en', '')},
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
                  elevation: 0,
                ),
                body: client
                    ? OrientationBuilder(builder: (context, orientation) {
                        if (orientation == Orientation.landscape) {
                          return homepages.elementAt(sselectedIndex);
                        } else {
                          return homepages.elementAt(sselectedIndex);
                        }
                      })
                    : TabBarView(
                        children: [
                          CricketAdmin(),
                          BasketballAdmin(),
                          BasketballAdmin(),
                          BasketballAdmin(),
                          BasketballAdmin(),
                        ],
                      ),
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
                      String psw = "";
                      //   if (indexOfItem == 2) {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => Calendar()),
                      //     );                  //
                      //     // showDialog(
                      //     //     context: context,
                      //     //     builder: (BuildContext context) {
                      //     //       return AlertDialog(
                      //     //         title: Text('Profile Selection'),
                      //     //         content: Container(
                      //     //           // Your profile content goes here
                      //     //           child: Text('Select your profile'),
                      //     //         ),
                      //     //         actions: <Widget>[
                      //     //           TextButton(
                      //     //             onPressed: () {
                      //     //               Navigator.of(context).pop();
                      //     //               showDialog(
                      //     //                 context: context,
                      //     //                 builder: (BuildContext context) {
                      //     //                   return AlertDialog(
                      //     //                     title: Text('Enter Admin Password'),
                      //     //                     actions: [
                      //     //                       TextField(
                      //     //                         keyboardType: TextInputType
                      //     //                             .visiblePassword,
                      //     //                         obscureText: true,
                      //     //                         onChanged: (value) {
                      //     //                           psw = value;
                      //     //                         },
                      //     //                       ),
                      //     //                       TextButton(
                      //     //                         onPressed: () {
                      //     //                           // Dismiss the second alert box
                      //     //                           if (psw == "psw") {
                      //     //                             Navigator.of(context).pop();
                      //     //                             client = false;
                      //     //                             Navigator.pushReplacement(
                      //     //                                 context,
                      //     //                                 MaterialPageRoute(
                      //     //                                     builder: (BuildContext
                      //     //                                             context) =>
                      //     //                                         MyApp()));
                      //     //                           }
                      //     //                         },
                      //     //                         child: Text('Ok'),
                      //     //                       ),
                      //     //                     ],
                      //     //                   );
                      //     //                 },
                      //     //               );
                      //     //             },
                      //     //             child: Text('Admin'),
                      //     //           ),
                      //     //           TextButton(
                      //     //             onPressed: () {
                      //     //               Navigator.of(context).pop();
                      //     //               client = true;
                      //     //               Navigator.pushReplacement(
                      //     //                   context,
                      //     //                   MaterialPageRoute(
                      //     //                       builder: (BuildContext context) =>
                      //     //                           MyApp()));
                      //     //             },
                      //     //             child: Text('Client'),
                      //     //           )
                      //     //         ],
                      //     //       );
                      //     //     });

                      //   } else if (indexOfItem == 1) {
                      //     if (client) {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => NewsPage()),
                      //       );
                      //     }
                      //   } else if (indexOfItem == 0) {
                      //     runApp(MyApp());
                      //   }
                      //
                    }),
              ),
            ))
        : AdminPage(
            title: "JHC Sports App (Admin)",
          );
  }
}
