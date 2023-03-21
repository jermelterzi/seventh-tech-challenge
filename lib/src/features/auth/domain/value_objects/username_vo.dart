import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/value_objects/value_object.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';

class UsernameVO extends ValueObject<String> {
  const UsernameVO({required super.value});

  @override
  Either<Failure, Unit> validate() {
    if (value.isEmpty) return const Left(EmptyUsernameFailure());

    return const Right(unit);
  }
}
