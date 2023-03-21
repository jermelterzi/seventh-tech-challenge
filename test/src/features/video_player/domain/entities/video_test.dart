import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';

void main() {
  test('validate', () async {
    // ARRANGE
    const video = Video(
      id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
      url: 'https://www.youtube.com/watch?v=9xwazD5SyVg',
    );

    // ACT
    final videoValidate = video.validate();

    // ASSERT
    expect(videoValidate, equals(const Right(unit)));
  });
}
