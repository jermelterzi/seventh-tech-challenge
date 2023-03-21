import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/datasources/video_player_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/models/video_model.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/repositories/video_player_repository_impl.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/repositories/video_player_repository.dart';

class MockVideoPlayerRemoteDataSource extends Mock
    implements VideoPlayerRemoteDataSource {}

void main() {
  late final VideoPlayerRemoteDataSource mockRemoteDataSource;
  late final VideoPlayerRepository repository;

  setUpAll(
    () {
      mockRemoteDataSource = MockVideoPlayerRemoteDataSource();
      repository =
          VideoPlayerRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    },
  );

  test(
    'Given that the data source returns a Video model when getVideo method is called then returns a Video',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getVideo(any()),
      ).thenAnswer(
        (_) async => const VideoModel(
          id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
          url:
              'https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8',
        ),
      );

      // ACT
      final getVideoResult = await repository.getVideo('bunny.mp4');

      // ASSERT
      expect(
        getVideoResult,
        const Right(
          Video(
            id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
            url:
                'https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8',
          ),
        ),
      );
      verify(() => mockRemoteDataSource.getVideo('bunny.mp4')).called(1);
    },
  );

  test(
    'Given that the data source throws an OfflineException when getVideo method is called then returns an OfflineFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getVideo(any()),
      ).thenThrow(
        OfflineException(),
      );

      // ACT
      final getVideoResult = await repository.getVideo('bunny.mp4');

      // ASSERT
      await expectLater(getVideoResult, equals(const Left(OfflineFailure())));
      verify(() => mockRemoteDataSource.getVideo('bunny.mp4')).called(1);
    },
  );

  test(
    'Given that the data source throws an InvalidTokenException when getVideo method is called then returns a InvalidTokenFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getVideo(any()),
      ).thenThrow(
        InvalidTokenException(),
      );

      // ACT
      final getVideoResult = await repository.getVideo('bunny.mp4');

      // ASSERT
      await expectLater(
        getVideoResult,
        equals(const Left(InvalidTokenFailure())),
      );
      verify(() => mockRemoteDataSource.getVideo('bunny.mp4')).called(1);
    },
  );

  test(
    'Given that the data source throws an BadRequestException when getVideo method is called then returns a BadRequestFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getVideo(any()),
      ).thenThrow(
        BadRequestException(),
      );

      // ACT
      final getVideoResult = await repository.getVideo('bunny.mp4');

      // ASSERT
      await expectLater(
        getVideoResult,
        equals(const Left(BadRequestFailure())),
      );
      verify(() => mockRemoteDataSource.getVideo('bunny.mp4')).called(1);
    },
  );
}
