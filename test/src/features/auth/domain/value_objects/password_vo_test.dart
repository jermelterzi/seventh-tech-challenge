import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/password_vo.dart';

void main() {
  test(
    'Given a valid password when validate method then return null',
    () async {
      // ARRANGE
      const password = PasswordVO(value: '1234');

      // ACT
      final isPasswordValid = password.validate();

      // ASSERT
      expect(isPasswordValid, equals(const Right(unit)));
    },
  );

  test(
    'Given a empty password when validate method then return a message',
    () {
      // ARRANGE
      const password = PasswordVO(value: '');

      // ACT
      final isPasswordValid = password.validate();

      // ASSERT
      expect(isPasswordValid, equals(const Left(EmptyPasswordFailure())));
    },
  );
}
