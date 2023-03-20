import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/exceptions.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/models/user_model.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> login(User user) async {
    try {
      final token = await remoteDataSource.getToken(UserModel.fromEntity(user));

      await localDataSource.saveToken(token);

      return const Right(unit);
    } on OfflineException {
      return const Left(OfflineFailure());
    } on BadRequestException {
      return const Left(BadRequestFailure());
    } on UnauthorizedException {
      return const Left(
        UnauthorizedFailure(message: 'Usuário ou senha incorretos!'),
      );
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
