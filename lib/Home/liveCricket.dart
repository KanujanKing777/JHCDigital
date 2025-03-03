import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_lib;

// Add constants at the top
const String _kDatabaseUrl =
    'https://latestjhcapp-default-rtdb.firebaseio.com/';
const double _kDesktopBreakpoint = 800.0;

final firebaseApp = Firebase.app();
FirebaseDatabase rtdb =
    FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: _kDatabaseUrl);

DatabaseReference refSports = FirebaseDatabase.instance.ref('Sports/');

// ignore: must_be_immutable
class LiveScoreWidgetCricket extends StatefulWidget {
  bool parameter = false;
  LiveScoreWidgetCricket({
    required this.parameter,
  });

  @override
  State<LiveScoreWidgetCricket> createState() =>
      _LiveScoreWidgetCricket(parameter: parameter);
}

int currentPage = 0;

class _LiveScoreWidgetCricket extends State<LiveScoreWidgetCricket> {
  bool parameter = false;
  _LiveScoreWidgetCricket({required this.parameter});

  // Helper methods for responsive design
  double _getContainerHeight(BuildContext context, double screenHeight) {
    return MediaQuery.of(context).size.width > _kDesktopBreakpoint
        ? screenHeight * 0.73
        : screenHeight * 0.27;
  }

  // Extract score processing logic
  Map<String, List<dynamic>> _processScores(Map<String, dynamic> matchData) {
    final scores = {
      'totalWicketTeam1': <int>[],
      'totalRunsTeam1': <int>[],
      // ... add other score lists
    };

    // Move score calculation logic here
    return scores;
  }

  // Extract widget building methods
  Widget _buildScoreCard(
      BuildContext context, int index, Map<String, dynamic> matchData) {
    return Container(
        // ... existing score card UI ...
        );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 150,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: refSports.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
          return _buildLoadingIndicator();
        }

        try {
          final data = snapshot.data!.snapshot.value;
          final screenHeight = MediaQuery.of(context).size.height;


          final jsonData = jsonEncode(data);
          final originalLiveScore =
              json.decode(jsonData) as Map<String, dynamic>;
          final liveScore =
              originalLiveScore['Cricket'] as Map<String, dynamic>;

          // Process match data
          final scores = _processScores(liveScore);

          // Build carousel
          return carousel_lib.CarouselSlider.builder(
            itemCount: scores['matches']?.length ?? 0,
            itemBuilder: (context, index, _) =>
                _buildScoreCard(context, index, scores),
            options: carousel_lib.CarouselOptions(
              aspectRatio: 16 / 16,
              height: _getContainerHeight(context, screenHeight),
              enableInfiniteScroll: true,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          );
        } catch (error) {
          return Center(child: Text('Error: $error'));
        }
      },
    );
  }
}
