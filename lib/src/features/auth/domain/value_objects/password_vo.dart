import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/value_objects/value_object.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';

class PasswordVO extends ValueObject<String> {
  const PasswordVO({required super.value});

  @override
  Either<Failure, Unit> validate() {
    if (value.isEmpty) return const Left(EmptyPasswordFailure());

    return const Right(unit);
  }
}
