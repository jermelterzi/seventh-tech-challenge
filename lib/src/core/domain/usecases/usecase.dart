import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';

abstract class UseCase<Return, Params> {
  Future<Either<Failure, Return>> call(Params params);
}
