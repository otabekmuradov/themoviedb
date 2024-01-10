import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youTubeKey;
  const MovieTrailerWidget({super.key, required this.youTubeKey});

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youTubeKey,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false, loop: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          handleColor: Colors.white,
          playedColor: Color(0xffff00253f),
          backgroundColor: Color(0xffff011a2d),
        ),
      ),
      builder: (context, player) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Image.asset(
                'assets/images/themoviedb_logo.png',
                height: 35,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: player,
              ),
            ));
      },
    );
  }
}
