import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerCustomSubtitle extends StatefulWidget {
  final String videoId = 'g_sfv9IVCu4';
  const YoutubePlayerCustomSubtitle({super.key});

  @override
  State<YoutubePlayerCustomSubtitle> createState() =>
      _YoutubePlayerCustomSubtitleState();
}

class _YoutubePlayerCustomSubtitleState
    extends State<YoutubePlayerCustomSubtitle> {
  late YoutubePlayerController _controller;

  // For Custom Subtitle and Subtitle displayin duration
  List<Subtitle> subtitle = [
    Subtitle(start: 2, end: 10, text: "Animated Contatiner Widget in Flutter"),
    // subtitle start at 2 second and end at 10 second
    Subtitle(start: 10, end: 20, text: "You can add your custom subtitle"),
    Subtitle(start: 20, end: 100, text: ""),
    // add mor subtitle as your requirement
  ];
  String subtitleText = "";

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false))
      ..addListener(_onPlayerStateChange);
  }

  void _onPlayerStateChange() {
    if (_controller.value.playerState == PlayerState.playing) {
      final currentTime = _controller.value.position.inSeconds;
      final currentSubtitle = subtitle.firstWhere((subtitle) =>
          currentTime >= subtitle.start && currentTime <= subtitle.end);

      // Update the UI with the current subtitle
      setState(() {
        subtitleText = currentSubtitle.text;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YouTube Player with Custom Subtitles"),
      ),
      body: Stack(
        children: [
          YoutubePlayer(controller: _controller),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 190),
            child: Text(
              subtitleText,
              style: const TextStyle(fontSize: 17, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Subtitle {
  final int start;
  final int end;
  final String text;

  Subtitle({required this.start, required this.end, required this.text});
}
