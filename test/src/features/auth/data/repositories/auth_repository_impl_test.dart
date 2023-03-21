import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/models/user_model.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late final AuthRemoteDataSource mockRemoteDataSource;
  late final AuthLocalDataSource mockLocalDataSource;
  late final AuthRepository repository;
  const tToken =
      '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs''';
  final tUser = User(
    id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
    username: 'candidato-seventh',
    password: '8n5zSrYq',
  );

  setUpAll(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    registerFallbackValue(
      UserModel(
        id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
        username: 'candidato-seventh',
        password: '8n5zSrYq',
      ),
    );
  });

  test(
    'Given a valid User when remote data source returns a String and local '
    'data source return an unit then return an unit',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getToken(any()),
      ).thenAnswer(
        (_) async => tToken,
      );

      when(
        () => mockLocalDataSource.saveToken(any()),
      ).thenAnswer(
        (_) async => unit,
      );

      // ACT
      final loginResult = await repository.login(tUser);

      // ASSERT
      expect(loginResult, equals(const Right(unit)));
      verify(
        () => mockRemoteDataSource.getToken(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
      ).called(1);
      verify(() => mockLocalDataSource.saveToken(tToken)).called(1);
    },
  );

  test(
    'Given a User when login method is called and the remote data source '
    'throws an OfflineException then return an OfflineFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getToken(any()),
      ).thenThrow(
        OfflineException(),
      );

      // ACT
      final loginResult = await repository.login(tUser);

      // ASSERT
      expect(loginResult, equals(const Left(OfflineFailure())));
      verify(
        () => mockRemoteDataSource.getToken(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
      ).called(1);
      verifyNever(() => mockLocalDataSource.saveToken(tToken));
    },
  );

  test(
    'Given the API remote data source throws a UnauthorizadeException when '
    'login method is called then return an BadRequestFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getToken(any()),
      ).thenThrow(
        UnauthorizedException(),
      );

      // ACT
      final loginResult = await repository.login(tUser);

      // ASSERT
      expect(
        loginResult,
        equals(
          const Left(
            UnauthorizedFailure(message: 'Usuário ou senha incorretos!'),
          ),
        ),
      );
      verify(
        () => mockRemoteDataSource.getToken(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
      ).called(1);
      verifyNever(() => mockLocalDataSource.saveToken(tToken));
    },
  );

  test(
    'Given a User when login method is called and the remote data source '
    'throws an BadRequestException then return an BadRequestFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getToken(any()),
      ).thenThrow(
        BadRequestException(),
      );

      // ACT
      final loginResult = await repository.login(tUser);

      // ASSERT
      expect(loginResult, equals(const Left(BadRequestFailure())));
      verify(
        () => mockRemoteDataSource.getToken(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
      ).called(1);
      verifyNever(() => mockLocalDataSource.saveToken(tToken));
    },
  );

  test(
    'Given a User when login method is called and the remote data source '
    'return the token but the local data source has some problem to save it '
    'then return a CacheFailure',
    () async {
      // ARRANGE
      when(
        () => mockRemoteDataSource.getToken(any()),
      ).thenAnswer(
        (_) async => tToken,
      );

      when(
        () => mockLocalDataSource.saveToken(any()),
      ).thenThrow(
        CacheException(),
      );

      // ACT
      final loginResult = await repository.login(tUser);

      // ASSERT
      expect(loginResult, equals(const Left(CacheFailure())));
      verify(
        () => mockRemoteDataSource.getToken(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
      ).called(1);
      verify(() => mockLocalDataSource.saveToken(tToken)).called(1);
    },
  );
}
