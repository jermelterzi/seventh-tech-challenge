import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<Unit, User> {
  final AuthRepository repository;

  Login({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(User user) {
    final validateUserResult = user.validate();

    return validateUserResult.fold(
      (failure) => Future.value(Left(failure)),
      (_) => repository.login(user),
    );
  }
}
