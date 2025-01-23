import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideoPlayer extends StatelessWidget {
  final String videoId;

  const FullScreenVideoPlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        onReady: () {
          debugPrint('YouTube Player is ready.');
        },
      ),
    );
  }
}