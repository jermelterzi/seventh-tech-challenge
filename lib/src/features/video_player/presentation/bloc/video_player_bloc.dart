import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_player/video_player.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final UseCase<Video, String> getVideoUseCase;
  late final VideoPlayerController videoPlayerController;

  VideoPlayerBloc({required this.getVideoUseCase})
      : super(VideoPlayerInitialStte()) {
    on<GetVideoEvent>(_getVideo);
  }

  @override
  Future<void> close() async {
    await videoPlayerController.dispose();
    await super.close();
  }

  Future<void> _getVideo(
    GetVideoEvent event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(VideoPlayerLoadingState());

    final getVideoResult = await getVideoUseCase(event.videoName);

    return getVideoResult.fold(
      (failure) => emit(VideoPlayerErrorState(errorMessage: failure.message)),
      (loadedVideo) async {
        videoPlayerController = VideoPlayerController.network(loadedVideo.url);

        await videoPlayerController.initialize();

        await videoPlayerController.play();

        return emit(
          VideoPlayerLoadedState(
            videoPlayerController: videoPlayerController,
          ),
        );
      },
    );
  }
}
