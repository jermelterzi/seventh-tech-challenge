import 'package:video_monitoring_seventh/src/core/constants/constants.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/models/video_model.dart';

abstract class VideoPlayerRemoteDataSource {
  Future<VideoModel> getVideo(String videoName);
}

class VideoPlayerRemoteDataSourceImpl implements VideoPlayerRemoteDataSource {
  final SeventhClient client;

  VideoPlayerRemoteDataSourceImpl({required this.client});

  @override
  Future<VideoModel> getVideo(String videoName) async {
    final response =
        await client.get(url: '${Constants.kBaseUrl}/video/$videoName');

    if (response.statusCode != 200) throw BadRequestException();

    return VideoModel.fromJson(response.body);
  }
}
