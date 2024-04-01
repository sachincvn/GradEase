import 'package:get_it/get_it.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerBlocs();
}

void _registerDataSources() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
}

void _registerRepositories() {
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()));
}

void _registerUseCases() {
  serviceLocator.registerFactory(() => StudentLoginUseCase(serviceLocator()));
}

void _registerBlocs() {
  serviceLocator.registerLazySingleton(
      () => AuthBloc(studentLoginUseCase: serviceLocator()));
}
