import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';

abstract class VideoPlayerRepository {
  Future<Either<Failure, Video>> getVideo(String videoName);
}
