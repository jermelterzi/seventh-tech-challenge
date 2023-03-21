import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/repositories/video_player_repository.dart';

class GetVideo implements UseCase<Video, String> {
  final VideoPlayerRepository repository;

  GetVideo({required this.repository});

  @override
  Future<Either<Failure, Video>> call(String videoName) {
    return repository.getVideo(videoName);
  }
}
