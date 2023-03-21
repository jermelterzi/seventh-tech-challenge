import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/entities/entity.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';

class Video extends Entity {
  final String url;

  const Video({required super.id, required this.url});

  @override
  Either<Failure, Unit> validate() => const Right(unit);
}
