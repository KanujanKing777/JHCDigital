import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FullScreenVideoPlayer extends StatelessWidget {
  final String videoId;

  const FullScreenVideoPlayer({Key? key, required this.videoId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the platform is web
    if (kIsWeb) {
      // Use iframe to embed the YouTube video for the web
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: HtmlWidget(
            """
              <iframe width="100%" height="100%" 
                src="https://www.youtube.com/embed/$videoId" 
                frameborder="0" 
                allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" 
                allowfullscreen>
              </iframe>
            """,
          ),
        ),
      );
    } else {
      // Use YoutubePlayer for mobile platforms (iOS/Android)
      return Scaffold(
        backgroundColor: Colors.black,
        body: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          ),
          onReady: () {
            debugPrint('YouTube Player is ready.');
          },
        ),
      );
    }
  }
}
