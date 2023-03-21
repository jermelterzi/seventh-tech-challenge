import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/usecases/login.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late final AuthRepository mockRepository;
  late final UseCase<Unit, User> loginUseCase;

  setUpAll(
    () {
      mockRepository = MockAuthRepository();
      loginUseCase = Login(repository: mockRepository);
    },
  );

  group(
    'valid user:',
    () {
      final tUser = User(
        id: 'c3d34ce9-a955-46cc-b67b-1b824dfa3786',
        username: 'candidato-seventh',
        password: '8n5zSrYq',
      );

      setUp(() => registerFallbackValue(tUser));

      test(
        'Given a valid User when the return of repository is unit then return '
        'unit',
        () async {
          // ARRANGE
          when(
            () => mockRepository.login(any()),
          ).thenAnswer(
            (_) async => const Right(unit),
          );

          // ACT
          final loginResult = await loginUseCase(tUser);

          // ASSERT
          expect(loginResult, equals(const Right(unit)));
          verify(() => mockRepository.login(tUser)).called(1);
        },
      );

      test(
        'Given a valid User when the return of repository is a Failure then '
        'return the Failure',
        () async {
          // ARRANGE
          when(
            () => mockRepository.login(any()),
          ).thenAnswer(
            (_) async => const Left(OfflineFailure()),
          );

          // ACT
          final loginResult = await loginUseCase(tUser);

          // ASSERT
          expect(loginResult, equals(const Left(OfflineFailure())));
          verify(() => mockRepository.login(tUser)).called(1);
        },
      );
    },
  );

  group(
    'invalid user:',
    () {
      final tInvalidUser = User(
        id: '',
        username: 'candidato-seventh',
        password: '',
      );

      test(
        'Given a invalid User when the use case is called then return a '
        'Failure',
        () async {
          // ARRANGE

          // ACT
          final loginResult = await loginUseCase(tInvalidUser);

          // ASSERT
          expect(loginResult, equals(const Left(EmptyPasswordFailure())));
          verifyNever(() => mockRepository.login(tInvalidUser));
        },
      );
    },
  );
}
