import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jhc_app/Admin/sportsmeetadmin.dart';
import 'package:jhc_app/Pages/NewsPage/NewsPage.dart';
import 'package:jhc_app/Pages/ScorePage/liveCricket.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:jhc_app/Pages/infoPage.dart';
import 'package:jhc_app/widgets/menus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jhc_app/Admin/cricketAdmin.dart';
import 'package:jhc_app/Admin/basketballAdmin.dart';
import 'package:jhc_app/main.dart';
import 'package:jhc_app/Admin/NewsPageAdmin.dart';
import 'package:jhc_app/Admin/shopAdmin.dart';
Timer? timer;
final firebaseApp = Firebase.app();
FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://latestjhcapp-default-rtdb.firebaseio.com/');
DatabaseReference ref = FirebaseDatabase.instance.ref('Cricket/');
int index = 0;
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
      theme: ThemeData.dark(),
      home: const AdminPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.title});

  final String title;

  @override
  State<AdminPage> createState() => _MyHomePageState();
}

final controller = TextEditingController();

class _MyHomePageState extends State<AdminPage> {
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

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: 'JHC',
        theme: ThemeData.dark(),
        supportedLocales: {const Locale('en', ' ')},
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.black,
            
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, // Change the color here
              ),
              
              title: Text(
                'JHC Sports App (Admin)',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.white),
                selectionColor: Colors.white,
              ),
              
              centerTitle: true,
              toolbarHeight: 80.2,
              toolbarOpacity: 0.7,
              titleSpacing: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              )),
              bottom: (index == 0 ) ? TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                Tab(child: Row(
                    children: [
                      Icon(Icons.sports_cricket),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      Text("Cricket", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),),
                    ],
                  )
                ),
                Tab(child: Row(
                    children: [
                      Icon(Icons.sports_basketball),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),

                      Text("Basketball", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),),
                    ],
                  )
                ),
                Tab(child: Row(
                    children: [
                      Icon(Icons.sports_football),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      Text("Football", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),),
                    ],
                  )
                ),
                Tab(child: Row(
                    children: [
                      Icon(Icons.sports_tennis),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      Text("Table Tennis", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),),
                    ],
                  )
                ),
                Tab(child: Row(
                    children: [
                      Icon(Icons.sports_hockey),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      Text("Hockey", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),),
                    ],
                  )
                ),

              ]) : null,
              
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 9, 74, 107),
            ),
            body:(index == 0) ?  TabBarView(
              children: [
                CricketAdmin(),
                BasketballAdmin(),
                BasketballAdmin(),
                BasketballAdmin(),
                BasketballAdmin(),
              ],
            ): (index == 2) ? NewsPageAdmin() : (index == 1) ? Sportsmeetadmin() : ShopAdmin(),
            bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.black12,
                
                currentIndex: index,
                fixedColor: const Color.fromARGB(255, 68, 208, 255),
                items: const [
                  BottomNavigationBarItem(
                    label: "Sports",
                    icon: Icon(Icons.sports),
                  ),
                  BottomNavigationBarItem(
                    label: "Sports Meet",
                    icon: Icon(Icons.sports_martial_arts),
                  ),
                  BottomNavigationBarItem(
                    label: "News",
                    icon: Icon(Icons.newspaper),
                  ),
                  BottomNavigationBarItem(
                    label: "Shop",
                    icon: Icon(Icons.shop),
                  ),
                  
                ],
                onTap: (int indexOfItem){
                    setState(() {
                      index = indexOfItem;
                    });
                  
                },
          ),
        )));
  }
}
