import 'package:flutter_test/flutter_test.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';

void main() {
  const userId = 'c3d34ce9-a955-46cc-b67b-1b824dfa3786';

  test(
      'Given a comparasion between Entities with the same id when == is called then return true',
      () async {
    // ARRANGE
    final entity = User(
      id: userId,
      username: 'candidato-seventh',
      password: '8n5zSrYq',
    );

    // ACT
    final isEqual = entity ==
        User(
          id: userId,
          username: 'jvermel',
          password: '123456',
        );

    // ASSERT
    expect(isEqual, equals(true));
  });

  test(
    'Given a Entity when get hashCode is called then return the hash code of the id of the Entity',
    () {
      // ARRANGE
      final entity = User(
        id: userId,
        username: 'candidato-seventh',
        password: '8n5zSrYq',
      );

      // ACT
      final valueObjectHash = entity.hashCode;

      // ASSERT
      expect(valueObjectHash, equals(userId.hashCode));
    },
  );
}
