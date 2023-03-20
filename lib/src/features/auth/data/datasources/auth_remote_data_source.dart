import 'dart:convert';

import 'package:video_monitoring_seventh/src/core/constants/constants.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> getToken(UserModel userModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SeventhClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> getToken(UserModel userModel) async {
    final response = await client.post(
      url: '${Constants.kBaseUrl}/login',
      body: userModel.toJson(),
    );

    if (response.statusCode == 401) throw UnauthorizedException();

    if (response.statusCode != 200) throw BadRequestException();

    final responseMap = jsonDecode(response.body);

    final token = responseMap[Constants.kTokenKey];

    return token;
  }
}
