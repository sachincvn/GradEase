import 'package:get_it/get_it.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/feeds/data/data_sourse/feed_post_remote_data_source.dart';
import 'package:grad_ease/features/feeds/data/repository/feed_post_repository_impl.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_reply_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/get_replies_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/getall_feed_post_usecase.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feed_detail_bloc/bloc/feed_detail_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';
import 'package:grad_ease/features/main/bloc/landing_page_bloc.dart';
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
    ..registerFactory<LocalDetailsRepository>(
        () => LocalDetailsRepositoryImpl(serviceLocator.get()))
    ..registerFactory<FeedPostRemoteDataSource>(
        () => FeedPostRemoteDataSourceImpl());
}

void _registerRepositories() {
  serviceLocator
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          authLocalDataSource: serviceLocator(),
        ))
    ..registerFactory<FeedPostRepository>(
        () => FeedPostRepositoryImpl(serviceLocator(), serviceLocator()));
}

void _registerUseCases() {
  serviceLocator
    ..registerFactory(
        () => StudentLoginUseCase(serviceLocator(), serviceLocator()))
    ..registerFactory(() => GetAllFeedPostUseCase(serviceLocator()))
    ..registerFactory(() => GetRepliesUseCase(serviceLocator()))
    ..registerFactory(() => AddReplyUseCase(serviceLocator()));
}

void _registerBlocs() {
  serviceLocator
    ..registerLazySingleton(() => AuthBloc(
          studentLoginUseCase: serviceLocator(),
          appUserCubit: serviceLocator(),
        ))
    ..registerLazySingleton(() => LandingPageBloc())
    ..registerLazySingleton(() => FeedPostBloc(serviceLocator()))
    ..registerLazySingleton(
        () => FeedDetailBloc(serviceLocator(), serviceLocator()));
}
