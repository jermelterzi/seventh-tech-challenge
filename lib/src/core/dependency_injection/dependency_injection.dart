import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_client.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/usecases/login.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/datasources/video_player_remote_data_source.dart';
import 'package:video_monitoring_seventh/src/features/video_player/data/repositories/video_player_repository_impl.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/entities/video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/repositories/video_player_repository.dart';
import 'package:video_monitoring_seventh/src/features/video_player/domain/usecases/get_video.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/bloc/video_player_bloc.dart';

final dependencyAssembly = GetIt.instance;

Future<void> init() async {
  // CORE
  dependencyAssembly
    ..registerLazySingleton<SeventhClient>(
      () => SeventhClientImpl(
        client: dependencyAssembly(),
        sharedPreferences: dependencyAssembly(),
        connectivity: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<Client>(Client.new)
    ..registerLazySingleton<Connectivity>(
      Connectivity.new,
    );

  final sharedPreferences = await SharedPreferences.getInstance();
  dependencyAssembly.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  // FEATURES
  _setupAuthDependencies();
  _setupVideoPlayerDependencies();
}

void _setupAuthDependencies() {
  dependencyAssembly
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<UseCase<Unit, User>>(
      () => Login(
        repository: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: dependencyAssembly(),
        localDataSource: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        client: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        sharedPreferences: dependencyAssembly(),
      ),
    );
}

void _setupVideoPlayerDependencies() {
  dependencyAssembly
    ..registerFactory<VideoPlayerBloc>(
      () => VideoPlayerBloc(
        getVideoUseCase: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<UseCase<Video, String>>(
      () => GetVideo(
        repository: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<VideoPlayerRepository>(
      () => VideoPlayerRepositoryImpl(
        remoteDataSource: dependencyAssembly(),
      ),
    )
    ..registerLazySingleton<VideoPlayerRemoteDataSource>(
      () => VideoPlayerRemoteDataSourceImpl(
        client: dependencyAssembly(),
      ),
    );
}
