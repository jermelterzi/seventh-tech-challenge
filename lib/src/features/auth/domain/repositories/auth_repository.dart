import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(User user);
}
