import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/datasources/video_player_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/repositories/video_player_repository.dart';

class VideoPlayerRepositoryImpl implements VideoPlayerRepository {
  final VideoPlayerRemoteDataSource remoteDataSource;

  VideoPlayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Video>> getVideo(String videoName) async {
    try {
      final video = await remoteDataSource.getVideo(videoName);

      return Right(video);
    } on OfflineException {
      return const Left(OfflineFailure());
    } on InvalidTokenException {
      return const Left(InvalidTokenFailure());
    } on BadRequestException {
      return const Left(BadRequestFailure());
    }
  }
}
