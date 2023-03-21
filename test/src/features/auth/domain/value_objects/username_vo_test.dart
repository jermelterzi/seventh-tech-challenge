import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/username_vo.dart';

void main() {
  test(
    'Given a valid username when validate method is called then return null',
    () async {
      // ARRANGE
      const email = UsernameVO(
        value: 'candidato-seventh',
      );

      // ACT
      final isEmailValid = email.validate();

      // ASSERT
      expect(isEmailValid, equals(const Right(unit)));
    },
  );

  test(
    'Given a empty username when validate method is called then return a '
    'message',
    () async {
      // ARRANGE
      const email = UsernameVO(value: '');

      // ACT
      final isEmailValid = email.validate();

      // ASSERT
      expect(isEmailValid, equals(const Left(EmptyUsernameFailure())));
    },
  );
}
