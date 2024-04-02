import 'package:get_it/get_it.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initHive();
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerBlocs();
}

Future<void> initHive() async {
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: "GradEase"));
}

void _registerDataSources() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl())
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(serviceLocator.get()));
}

void _registerRepositories() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
        authLocalDataSource: serviceLocator(),
      ));
}

void _registerUseCases() {
  serviceLocator.registerFactory(() => StudentLoginUseCase(serviceLocator()));
}

void _registerBlocs() {
  serviceLocator.registerLazySingleton(() => AuthBloc(
        studentLoginUseCase: serviceLocator(),
        appUserCubit: serviceLocator(),
      ));
}
