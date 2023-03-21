import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFullScreenPage extends StatefulWidget {
  const VideoPlayerFullScreenPage({
    required this.controller,
    super.key,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerFullScreenPage> createState() =>
      _VideoPlayerFullScreenPageState();
}

class _VideoPlayerFullScreenPageState extends State<VideoPlayerFullScreenPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]).then((_) => SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: VideoPlayer(widget.controller),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.fullscreen_exit,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ])
        .then(
          (_) => SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          ),
        )
        .then(
          (_) => super.dispose(),
        );
  }
}
