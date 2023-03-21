import 'dart:convert';

import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';

class VideoModel extends Video {
  const VideoModel({
    required super.id,
    required super.url,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String? ?? 'ce10b1e8-6656-44f2-b7be-20504f869eae',
      url: map['url'] as String,
    );
  }

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'VideoModel(id: $id, url: $url)';
}
