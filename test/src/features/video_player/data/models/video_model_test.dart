import 'package:flutter_test/flutter_test.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/models/video_model.dart';

void main() {
  final tMap = {
    'url': 'https://www.youtube.com/watch?v=9xwazD5SyVg',
  };

  const tJson = '{"url":"https://www.youtube.com/watch?v=9xwazD5SyVg"}';

  const tModel = VideoModel(
    id: 'ce10b1e8-6656-44f2-b7be-20504f869eae',
    url: 'https://www.youtube.com/watch?v=9xwazD5SyVg',
  );

  test('fromMap', () async {
    // ACT
    final videoModel = VideoModel.fromMap(tMap);

    // ASSERT
    expect(videoModel, equals(tModel));
  });

  test('fromJson', () async {
    // ACT
    final videoModel = VideoModel.fromJson(tJson);

    // ASSERT
    expect(videoModel, equals(tModel));
  });

  test('toMap', () async {
    // ACT
    final map = tModel.toMap();

    // ASSERT
    expect(map, equals(tMap));
  });

  test('toJson', () async {
    // ACT
    final json = tModel.toJson();

    // ASSERT
    expect(json, equals(tJson));
  });

  test('toString', () async {
    // ACT
    final modelString = tModel.toString();

    // ASSERT
    expect(
      modelString,
      'VideoModel(id: ce10b1e8-6656-44f2-b7be-20504f869eae, url: https://www.youtube.com/watch?v=9xwazD5SyVg)',
    );
  });
}
