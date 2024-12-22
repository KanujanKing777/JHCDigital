import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:jhc_app/Pages/infoPage.dart';
import 'package:jhc_app/widgets/menus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jhc_app/Admin/cricketAdmin.dart';
import 'package:jhc_app/Admin/basketballAdmin.dart';
import 'package:jhc_app/Admin/admin.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:jhc_app/Pages/Calendar/calendar.dart';
import 'package:jhc_app/Pages/RealHomePage.dart';
Timer? timer;
final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');

DatabaseReference ref = FirebaseDatabase.instance.ref('Cricket/');
final client = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  final homepages = [RealHomePage(), LiveScoreWidgetCricket(parameter: false,), NewsPage(), Calendar()];
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
                    showUnselectedLabels: true,                 
                    backgroundColor: Color.fromARGB(255, 12, 12, 12),
                    unselectedItemColor: Colors.white,
                    currentIndex: sselectedIndex,         
                    
                    fixedColor: const Color.fromARGB(255, 68, 208, 255),
                    type: BottomNavigationBarType.fixed,
                    items:  [
                      BottomNavigationBarItem(
                        label: "Home",
                        icon: Icon(FontAwesomeIcons.home, size:MediaQuery.of(context).size.width * 0.07),
                        activeIcon: Icon(FontAwesomeIcons.homeAlt, size:MediaQuery.of(context).size.width * 0.07)
                      ),
                      BottomNavigationBarItem(
                        label: "Sports",
                        icon: Icon(FontAwesomeIcons.basketball, size:MediaQuery.of(context).size.width * 0.07),
                        activeIcon: Icon(FontAwesomeIcons.basketball, size:MediaQuery.of(context).size.width * 0.07),
                      ),
                      BottomNavigationBarItem(
                        label: "News",
                        icon: Icon(FontAwesomeIcons.newspaper, size:MediaQuery.of(context).size.width * 0.07),
                        activeIcon: Icon(FontAwesomeIcons.solidNewspaper, size:MediaQuery.of(context).size.width * 0.07),
                      ),
                      BottomNavigationBarItem(
                        label: "Calendar",
                        icon: Icon(FontAwesomeIcons.calendar, size:MediaQuery.of(context).size.width * 0.07),
                        activeIcon: Icon(FontAwesomeIcons.calendar, size:MediaQuery.of(context).size.width * 0.07)
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
