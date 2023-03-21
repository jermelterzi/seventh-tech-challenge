import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_response.dart';

abstract class SeventhClient {
  Future<SeventhResponse> post({
    required String url,
    required String body,
  });
  Future<SeventhResponse> get({required String url});
}

class SeventhClientImpl implements SeventhClient {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final Connectivity connectivity;

  final baseUrl = 'http://mobiletest.seventh.com.br';

  SeventhClientImpl({
    required this.client,
    required this.sharedPreferences,
    required this.connectivity,
  });

  @override
  Future<SeventhResponse> get({required String url}) async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) throw OfflineException();

    final token = sharedPreferences.getString('token');

    if (token == null) throw InvalidTokenException();

    final response = await client.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'X-Access-Token': token,
      },
    );

    return SeventhResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<SeventhResponse> post({
    required String url,
    required String body,
  }) async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) throw OfflineException();

    final response = await client.post(
      Uri.parse(url),
      body: body,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return SeventhResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }
}
