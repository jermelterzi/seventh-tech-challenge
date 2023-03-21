import 'package:flutter_test/flutter_test.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/password_vo.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/value_objects/username_vo.dart';

void main() {
  test(
      'Given a comparasion between ValueObjects when == is called then return '
      'true', () async {
    // ARRANGE
    const valueObject = UsernameVO(value: 'candidato-seventh');

    // ACT
    final isEqual = valueObject == const UsernameVO(value: 'candidato-seventh');

    // ASSERT
    expect(isEqual, equals(true));
  });

  test(
    'Given a ValueObject when get hashCode is called then return the hash code '
    'of the value of ValueObject',
    () {
      // ARRANGE
      const valueObject = PasswordVO(value: '8n5zSrYq');

      // ACT
      final valueObjectHash = valueObject.hashCode;

      // ASSERT
      expect(valueObjectHash, equals('8n5zSrYq'.hashCode));
    },
  );
}
