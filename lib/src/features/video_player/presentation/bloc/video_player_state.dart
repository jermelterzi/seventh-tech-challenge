part of 'video_player_bloc.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

class VideoPlayerInitialStte extends VideoPlayerState {}

class VideoPlayerLoadingState extends VideoPlayerState {}

class VideoPlayerErrorState extends VideoPlayerState {
  final String errorMessage;

  const VideoPlayerErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class VideoPlayerLoadedState extends VideoPlayerState {
  final VideoPlayerController videoPlayerController;

  const VideoPlayerLoadedState({
    required this.videoPlayerController,
  });

  @override
  List<Object> get props => [videoPlayerController];
}
