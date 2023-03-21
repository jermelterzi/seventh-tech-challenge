part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class GetVideoEvent extends VideoPlayerEvent {
  final String videoName;

  const GetVideoEvent({required this.videoName});

  @override
  List<Object> get props => [videoName];
}
