import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/core/dependency_injection/dependency_injection.dart'
    as di;
import 'package:video_monitoring_seventh/src/core/presentation/widgets/seventh_snack_bars.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/bloc/video_player_bloc.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/pages/video_player_full_screen_page.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/widgets/video_player_button.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    super.key,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final VideoPlayerBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = di.dependencyAssembly<VideoPlayerBloc>();
    bloc.add(const GetVideoEvent(videoName: 'bunny.mp4'));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  var _isPaused = false;
  var _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Image.asset(
            'assets/seventh_logo_white.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      body: BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is VideoPlayerErrorState) {
            SeventhSnackBars.showErrorSnackBar(
              context,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          if (state is VideoPlayerLoadedState) {
            final controller = state.videoPlayerController;

            return Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Center(
                    child: Text(
                      'bunny.mp4',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          )
                        : CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      VideoPlayerButton(
                        iconData:
                            _isMuted ? Icons.volume_up_sharp : Icons.volume_off,
                        onPressed: () => _onMuteButtonPressed(controller),
                      ),
                      VideoPlayerButton(
                        iconData: _isPaused ? Icons.play_arrow : Icons.pause,
                        onPressed: () => _onPlayPauseButtonPressed(controller),
                      ),
                      VideoPlayerButton(
                        iconData: Icons.fullscreen,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VideoPlayerFullScreenPage(
                                controller: controller,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _onMuteButtonPressed(VideoPlayerController controller) {
    if (_isMuted) {
      controller.setVolume(1);

      return setState(() {
        _isMuted = !_isMuted;
      });
    }

    controller.setVolume(0);

    return setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _onPlayPauseButtonPressed(VideoPlayerController controller) {
    if (_isPaused) {
      controller.play();

      return setState(() {
        _isPaused = !_isPaused;
      });
    }

    controller.pause();

    return setState(() {
      _isPaused = !_isPaused;
    });
  }
}
