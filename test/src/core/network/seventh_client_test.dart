import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_response.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late final Connectivity mockConnectivity;
  late final http.Client mockHttpClient;
  late final SharedPreferences mockSharedPreferences;
  late final SeventhClient client;

  setUpAll(() {
    mockHttpClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    mockConnectivity = MockConnectivity();
    client = SeventhClientImpl(
      client: mockHttpClient,
      sharedPreferences: mockSharedPreferences,
      connectivity: mockConnectivity,
    );
  });

  group(
    'get:',
    () {
      const getUrl = 'http://mobiletest.seventh.com.br/video/bunny.mp4';
      const tToken =
          '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs''';

      setUpAll(() {
        registerFallbackValue(
          Uri.parse(getUrl),
        );
      });

      test(
        'Given user is online and the token has a token saved when a valid '
        'request is called then return a SeventhResponse',
        () async {
          // ARRANGE
          when(
            mockConnectivity.checkConnectivity,
          ).thenAnswer(
            (_) async => ConnectivityResult.mobile,
          );

          when(
            () => mockSharedPreferences.getString(any()),
          ).thenAnswer(
            (_) => tToken,
          );

          when(
            () => mockHttpClient.get(any(), headers: any(named: 'headers')),
          ).thenAnswer(
            (_) async => http.Response(
              '{"url": "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8"}',
              200,
            ),
          );

          // ACT
          final response = await client.get(url: getUrl);

          // ASSERT
          expect(
            response,
            equals(
              const SeventhResponse(
                statusCode: 200,
                body:
                    '{"url": "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8"}',
              ),
            ),
          );
          verify(mockConnectivity.checkConnectivity).called(1);
          verify(() => mockSharedPreferences.getString('token')).called(1);
          verify(
            () => mockHttpClient.get(
              Uri.parse(getUrl),
              headers: {
                'accept': 'application/json',
                'X-Access-Token': tToken,
              },
            ),
          ).called(1);
        },
      );

      test(
        'Given user is offline when a valid request is called then throw a '
        'OfflineException',
        () async {
          // ARRANGE
          when(
            mockConnectivity.checkConnectivity,
          ).thenAnswer(
            (_) async => ConnectivityResult.none,
          );

          // ACT
          final call = client.get;

          // ASSERT
          await expectLater(
            call(url: getUrl),
            throwsA(const TypeMatcher<OfflineException>()),
          );
          verify(mockConnectivity.checkConnectivity).called(1);
          verifyNever(() => mockSharedPreferences.getString('token'));
          verifyNever(
            () => mockHttpClient.get(
              Uri.parse(getUrl),
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          );
        },
      );

      test(
        'Given user is online but the token is not saved when a valid request '
        'is called then throw a InvalidTokenException',
        () async {
          // ARRANGE
          when(
            mockConnectivity.checkConnectivity,
          ).thenAnswer(
            (_) async => ConnectivityResult.wifi,
          );

          when(
            () => mockSharedPreferences.getString(any()),
          ).thenReturn(null);

          // ACT
          final call = client.get;

          // ASSERT
          await expectLater(
            call(url: getUrl),
            throwsA(const TypeMatcher<InvalidTokenException>()),
          );
          verify(mockConnectivity.checkConnectivity).called(1);
          verify(() => mockSharedPreferences.getString('token')).called(1);
          verifyNever(
            () => mockHttpClient.get(
              Uri.parse(getUrl),
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          );
        },
      );
    },
  );

  group(
    'post',
    () {
      const postUrl = 'http://mobiletest.seventh.com.br/login';

      setUp(() => registerFallbackValue(Uri.parse(postUrl)));

      test(
        'Given user is online when a post request is called then return a '
        'SeventhResponse',
        () async {
          // ARRANGE
          when(
            mockConnectivity.checkConnectivity,
          ).thenAnswer(
            (_) async => ConnectivityResult.wifi,
          );

          when(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              '''{"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs"}''',
              200,
            ),
          );

          // ACT
          final response = await client.post(
            url: postUrl,
            body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
          );

          // ASSERT
          expect(
            response,
            equals(
              const SeventhResponse(
                body:
                    '''{"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7ImlkIjoiNDM4MWI2ZmEtNDEzNi00MDRhLTlkOTctOGU3N2NjNjdhOGU4IiwidXNlcm5hbWUiOiJjYW5kaWRhdG8tc2V2ZW50aCIsImxhc3RMb2dpbiI6IjIwMjMtMDMtMTlUMjE6MTA6NTEuNzY0WiJ9LCJpYXQiOjE2NzkyNjAyNTEsImV4cCI6MTY3OTM0NjY1MX0.oBnvc6M08X6zQX2_ZYDI-qezaVBZNkSSHmnJs-e1WJs"}''',
                statusCode: 200,
              ),
            ),
          );
          verify(mockConnectivity.checkConnectivity).called(1);
          verify(
            () => mockHttpClient.post(
              Uri.parse(postUrl),
              body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          ).called(1);
        },
      );

      test(
        'Given the user is offline when a valid post request is called then '
        'throw a OfflineException',
        () async {
          // ARRANGE
          when(
            mockConnectivity.checkConnectivity,
          ).thenAnswer(
            (_) async => ConnectivityResult.none,
          );

          // ACT
          final call = client.post;

          // ASSERT
          await expectLater(
            call(
              url: postUrl,
              body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
            ),
            throwsA(const TypeMatcher<OfflineException>()),
          );
          verify(mockConnectivity.checkConnectivity).called(1);
          verifyNever(
            () => mockHttpClient.post(
              Uri.parse(postUrl),
              body: '{"username":"candidato-seventh","password":"8n5zSrYq"}',
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          );
        },
      );
    },
  );
}
