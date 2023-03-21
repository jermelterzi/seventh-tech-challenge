import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_response.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/models/user_model.dart';

class MockSeventhClient extends Mock implements SeventhClient {}

void main() {
  late final SeventhClient mockClient;
  late final AuthRemoteDataSource remoteDataSource;

  setUpAll(() {
    mockClient = MockSeventhClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client: mockClient);
  });

  test(
    'Given a UserModel when getToken method is called and the response from '
    'API is a success then return the token',
    () async {
      // ARRANGE
      when(
        () => mockClient.post(url: any(named: 'url'), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => const SeventhResponse(
          statusCode: 200,
          body:
              '''{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs"}''',
        ),
      );

      // ACT
      final token = await remoteDataSource.getToken(
        UserModel(
          id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
          username: 'candidato-seventh',
          password: '8n5zSrYq',
        ),
      );

      // ASSERT
      expect(
        token,
        equals(
          '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs''',
        ),
      );
      verify(
        () => mockClient.post(
          url: 'http://mobiletest.seventh.com.br/login',
          body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
        ),
      ).called(1);
    },
  );

  test(
    'Given a failure response from API when the get token method is called '
    'then throws a BadRequestException',
    () async {
      // ARRANGE
      when(
        () => mockClient.post(url: any(named: 'url'), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => const SeventhResponse(
          statusCode: 400,
          body: '{"message":"Falha na requisição."}',
        ),
      );

      // ACT
      final getTokenCall = remoteDataSource.getToken;

      // ASSERT
      await expectLater(
        getTokenCall(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
        throwsA(const TypeMatcher<BadRequestException>()),
      );
      verify(
        () => mockClient.post(
          url: 'http://mobiletest.seventh.com.br/login',
          body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
        ),
      ).called(1);
    },
  );

  test(
    'Given a unauthorized response from API when the get token method is '
    'called then throws a UnauthorizedException',
    () async {
      // ARRANGE
      when(
        () => mockClient.post(url: any(named: 'url'), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => const SeventhResponse(
          statusCode: 401,
          body: '{"message":"Unauthorized"}',
        ),
      );

      // ACT
      final getTokenCall = remoteDataSource.getToken;

      // ASSERT
      await expectLater(
        getTokenCall(
          UserModel(
            id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
            username: 'candidato-seventh',
            password: '8n5zSrYq',
          ),
        ),
        throwsA(const TypeMatcher<UnauthorizedException>()),
      );
      verify(
        () => mockClient.post(
          url: 'http://mobiletest.seventh.com.br/login',
          body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
        ),
      ).called(1);
    },
  );
}
