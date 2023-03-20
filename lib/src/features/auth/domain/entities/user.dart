import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/entities/entity.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/password_vo.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/username_vo.dart';

class User extends Entity<User> {
  final UsernameVO username;
  final PasswordVO password;

  User({
    required super.id,
    required String username,
    required String password,
  })  : username = UsernameVO(value: username),
        password = PasswordVO(value: password);

  @override
  Either<Failure, Unit> validate() {
    return username.validate().flatMap((_) => password.validate());
  }
}
