import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/repositories/video_player_repository.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/usecases/get_video.dart';

class MockVideoPlayerRepository extends Mock implements VideoPlayerRepository {}

void main() {
  late final VideoPlayerRepository mockRepository;
  late final UseCase<Video, String> getVideoUseCase;

  setUpAll(() {
    mockRepository = MockVideoPlayerRepository();
    getVideoUseCase = GetVideo(repository: mockRepository);
  });

  test(
      'Given the repository returns a right value when get video use case is called then returns a Video',
      () async {
    // ARRANGE
    when(
      () => mockRepository.getVideo(any()),
    ).thenAnswer(
      (_) async => const Right(
        Video(
          id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
          url: 'https://www.youtube.com/watch?v=9xwazD5SyVg',
        ),
      ),
    );

    // ACT
    final getVideoResult = await getVideoUseCase('bunny.mp4');

    // ASSERT
    expect(
      getVideoResult,
      equals(
        const Right(
          Video(
            id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
            url: 'https://www.youtube.com/watch?v=9xwazD5SyVg',
          ),
        ),
      ),
    );
    verify(() => mockRepository.getVideo('bunny.mp4')).called(1);
  });

  test(
    'Given the repository returns a left value when get video use case is called then returns a Failure',
    () async {
      // ARRANGE
      when(
        () => mockRepository.getVideo(any()),
      ).thenAnswer(
        (_) async => const Left(BadRequestFailure()),
      );

      // ACT
      final getVideoResult = await getVideoUseCase('bunny.mp4');

      // ASSERT
      expect(getVideoResult, equals(const Left(BadRequestFailure())));
      verify(() => mockRepository.getVideo('bunny.mp4')).called(1);
    },
  );
}
