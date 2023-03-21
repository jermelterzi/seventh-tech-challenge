import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_response.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/datasources/video_player_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/models/video_model.dart';

class MockSeventhClient extends Mock implements SeventhClient {}

void main() {
  late final SeventhClient mockClient;
  late final VideoPlayerRemoteDataSource remoteDataSource;

  setUpAll(
    () {
      mockClient = MockSeventhClient();
      remoteDataSource = VideoPlayerRemoteDataSourceImpl(client: mockClient);
    },
  );

  test(
    'Given the response from the API is a success when getVideo method is '
    'called then return a VideoModel with the url of the body of response',
    () async {
      // ARRANGE
      when(
        () => mockClient.get(url: any(named: 'url')),
      ).thenAnswer(
        (_) async => const SeventhResponse(
          statusCode: 200,
          body:
              '{"url":"https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8"}',
        ),
      );

      // ACT
      final video = await remoteDataSource.getVideo('bunny.mp4');

      // ASSERT
      expect(
        video,
        equals(
          const VideoModel(
            id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
            url:
                'https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8',
          ),
        ),
      );
      verify(
        () => mockClient.get(
          url: 'http://mobiletest.seventh.com.br/video/bunny.mp4',
        ),
      ).called(1);
    },
  );

  test(
    'Given the request fails when the response is different of 200 then throws '
    'BadRequestException',
    () async {
      // ARRANGE
      when(
        () => mockClient.get(url: any(named: 'url')),
      ).thenAnswer(
        (_) async => const SeventhResponse(
          statusCode: 400,
          body: '{"message":"BadRequest"}',
        ),
      );

      // ACT
      final getVideoCall = remoteDataSource.getVideo;

      // ASSERT
      await expectLater(
        getVideoCall('bunny.mp4'),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
      verify(
        () => mockClient.get(
          url: 'http://mobiletest.seventh.com.br/video/bunny.mp4',
        ),
      ).called(1);
    },
  );
}
