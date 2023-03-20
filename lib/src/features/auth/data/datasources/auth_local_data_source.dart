import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_monitoring_seventh/src/core/constants/constants.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<Unit> saveToken(String token);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> saveToken(String token) async {
    final isCacheSuccess = await sharedPreferences.setString(
      Constants.kTokenKey,
      token,
    );

    if (!isCacheSuccess) throw CacheException();

    return unit;
  }
}
