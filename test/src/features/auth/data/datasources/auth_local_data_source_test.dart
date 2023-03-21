import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late final SharedPreferences mockSharedPreferences;
  late final AuthLocalDataSource localDataSource;
  const tToken =
      '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs''';

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        AuthLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  test(
    'Given the SharedPreferences conclude the caching of the token when save '
    'token method is called then return an unit',
    () async {
      // ARRANGE
      when(
        () => mockSharedPreferences.setString(any(), any()),
      ).thenAnswer(
        (_) async => true,
      );

      // ACT
      final cacheResult = await localDataSource.saveToken(tToken);

      // ASSERT
      expect(cacheResult, equals(unit));
      verify(() => mockSharedPreferences.setString('token', tToken)).called(1);
    },
  );

  test(
    'Given the SharedPreferences fails to cache the token when save token '
    'method is called then throws a CacheException',
    () async {
      // ARRANGE
      when(
        () => mockSharedPreferences.setString(any(), any()),
      ).thenAnswer(
        (_) async => false,
      );

      // ACT
      final cacheCall = localDataSource.saveToken;

      // ASSERT
      await expectLater(
        cacheCall(tToken),
        throwsA(const TypeMatcher<CacheException>()),
      );
      verify(() => mockSharedPreferences.setString('token', tToken)).called(1);
    },
  );
}
