import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';

void main() {
  test(
    'Given a valid user when validate method is called then return unit',
    () async {
      // ARRANGE
      final user = User(
        id: '',
        username: 'candidato-seventh',
        password: '8n5zSrYq',
      );

      // ACT
      final userValidate = user.validate();

      // ASSERT
      expect(userValidate, equals(const Right(unit)));
    },
  );

  test(
    'Given a empty username when validated method is called then return '
    'EmptyUsernameFailure',
    () {
      // ARRANGE
      final user = User(
        id: '',
        username: '',
        password: '8n5zSrYq',
      );

      // ACT
      final userValidate = user.validate();

      // ASSERT
      expect(userValidate, equals(const Left(EmptyUsernameFailure())));
    },
  );

  test(
    'Given a empty password when validated method is called then return '
    'EmptyPasswordFailure',
    () {
      // ARRANGE
      final user = User(
        id: '',
        username: 'candidato-seventh',
        password: '',
      );

      // ACT
      final userValidate = user.validate();

      // ASSERT
      expect(userValidate, equals(const Left(EmptyPasswordFailure())));
    },
  );
}
