part of 'video_player_bloc.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();  

  @override
  List<Object> get props => [];
}
class VideoPlayerInitial extends VideoPlayerState {}
