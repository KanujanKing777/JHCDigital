import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class SecondPage extends StatelessWidget {
  final ScoreData scoreData;
  final String eTeam1;
  final String eTeam2;
  final String matchName;
  final String eTotalScoreTeam1;
  final String eTotalScoreTeam2;
  final String eTeam1Logo;
  final String eTeam2Logo;
  final String matchid;

  late final DatabaseReference refSports =
      FirebaseDatabase.instance.ref('Sports/');

  SecondPage({
    required this.eTeam1,
    required this.eTeam2,
    required this.matchName,
    required this.eTotalScoreTeam1,
    required this.eTotalScoreTeam2,
    required this.eTeam1Logo,
    required this.eTeam2Logo,
    required this.matchid,
  }) : scoreData = ScoreData(
          eTeam1: eTeam1,
          eTeam2: eTeam2,
          matchName: matchName,
          eTotalScoreTeam1: eTotalScoreTeam1,
          eTotalScoreTeam2: eTotalScoreTeam2,
          eTeam1Logo: eTeam1Logo,
          eTeam2Logo: eTeam2Logo,
          matchid: matchid,
        );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: refSports.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!_isValidSnapshot(snapshot)) {
            return const SizedBox();
          }

          final data = _processSnapshotData(snapshot);
          final screenDimensions = _getScreenDimensions(context);

          return SafeArea(
            child: DefaultTabController(
              length: (matchid == "match") ? 2 : 3,
              child: _buildScaffold(context, data, screenDimensions),
            ),
          );
        });
  }

  bool _isValidSnapshot(AsyncSnapshot<DatabaseEvent> snapshot) {
    return snapshot.hasData &&
        snapshot.data != null &&
        snapshot.data!.snapshot.value != null;
  }

  Map<String, dynamic> _processSnapshotData(
      AsyncSnapshot<DatabaseEvent> snapshot) {
    final jsonData = jsonEncode(snapshot.data!.snapshot.value);
    final data = json.decode(jsonData);
    return data;
  }

  ScreenDimensions _getScreenDimensions(BuildContext context) {
    return ScreenDimensions(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width);
  }

  Widget _buildScaffold(BuildContext context, Map<String, dynamic> data,
      ScreenDimensions dimensions) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: _buildTabViews(context, data, dimensions),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(matchName.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      elevation: 1.0,
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      bottom: TabBar(
        labelPadding: EdgeInsets.only(left: 4.0, right: 4),
        indicatorWeight: 1.0,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        tabs: [
          Tab(
            text: "SUMMARY",
          ),
          if (matchid != "match")
            Tab(
              text: "SQUAD",
            ),
          Tab(
            text: "SCORECARD",
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabViews(BuildContext context, Map<String, dynamic> data,
      ScreenDimensions dimensions) {
    return [
      _buildSummaryTab(context, data, dimensions),
      if (matchid != "match") _buildSquadTab(context),
      _buildScorecardTab(context, data),
    ];
  }

  Widget _buildSummaryTab(BuildContext context, Map<String, dynamic> data,
      ScreenDimensions dimensions) {
    return _buildSummaryContent(context, data, dimensions);
  }

  Widget _buildSquadTab(BuildContext context) {
    return _buildSquadContent(context);
  }

  Widget _buildScorecardTab(BuildContext context, Map<String, dynamic> data) {
    return _buildScorecardContent(context, data);
  }

  Widget _buildSummaryContent(BuildContext context, Map<String, dynamic> data,
      ScreenDimensions dimensions) {
    return _buildSummaryContentContent(context, data, dimensions);
  }

  Widget _buildSquadContent(BuildContext context) {
    return _buildSquadContentContent(context);
  }

  Widget _buildScorecardContent(
      BuildContext context, Map<String, dynamic> data) {
    return _buildScorecardContentContent(context, data);
  }

  Widget _buildSummaryContentContent(BuildContext context,
      Map<String, dynamic> data, ScreenDimensions dimensions) {
    // Implementation of _buildSummaryContentContent
    return Container();
  }

  Widget _buildSquadContentContent(BuildContext context) {
    // Implementation of _buildSquadContentContent
    return Container();
  }

  Widget _buildScorecardContentContent(
      BuildContext context, Map<String, dynamic> data) {
    // Implementation of _buildScorecardContentContent
    return Container();
  }
}

class ScoreData {
  int etotalRunsTeam1 = 0;
  int etotalRunsTeam2 = 0;
  int etotalWicketTeam1 = 0;
  int etotalWicketTeam2 = 0;
  String eTeam1;
  String eTeam2;
  String eoverpointball = "";
  String eoverpointball1 = "";
  String eoverpointball2 = "";
  String matchName;
  String ebatter = "";
  String eballer = "";
  String eTotalScoreTeam1;
  String eTotalScoreTeam2;
  String eTeam1Logo;
  String eTeam2Logo;
  String matchid;
  bool fun = false;
  DatabaseReference refSports = FirebaseDatabase.instance.ref('Sports/');

  ScoreData({
    required this.eTeam1,
    required this.eTeam2,
    required this.matchName,
    required this.eTotalScoreTeam1,
    required this.eTotalScoreTeam2,
    required this.eTeam1Logo,
    required this.eTeam2Logo,
    required this.matchid,
  });
}

class ScreenDimensions {
  final double height;
  final double width;

  ScreenDimensions({required this.height, required this.width});
}
