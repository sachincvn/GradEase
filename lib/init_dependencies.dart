import 'package:get_it/get_it.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/admin/data/data_source/admin_remote_data_source.dart';
import 'package:grad_ease/features/admin/data/repository/admin_repository_impl.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/admin/presentation/bloc/add_community/add_community_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/add_timetable/add_timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_assignment/admin_assignment_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_bloc/admin_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_feedback/admin_feedback_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/communites_bloc/communites_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/edit_user_bloc/edit_user_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/students_bloc/students_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/timetable_bloc/timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/upsert_assignment_bloc/upsert_assignment_bloc.dart';
import 'package:grad_ease/features/assignment/data/data_source/assignmnet_remote_data_source.dart';
import 'package:grad_ease/features/assignment/data/repository/assignment_repository_impl.dart';
import 'package:grad_ease/features/assignment/domain/repository/assignment_repository.dart';
import 'package:grad_ease/features/assignment/presentation/bloc/assignment_bloc/assignment_bloc.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/auth/domain/usecase/admin_login_usecase.dart';
import 'package:grad_ease/features/auth/domain/usecase/register_student_use_case.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/communities/data/data_source/community_remote_data_source.dart';
import 'package:grad_ease/features/communities/data/repository/community_repository_impl.dart';
import 'package:grad_ease/features/communities/domain/repository/communtiy_repository.dart';
import 'package:grad_ease/features/communities/domain/usecase/get_community_messages_use_case.dart';
import 'package:grad_ease/features/communities/domain/usecase/get_community_use_case.dart';
import 'package:grad_ease/features/communities/domain/usecase/send_message_use_case.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_bloc/community_bloc.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_detail/community_detail_bloc.dart';
import 'package:grad_ease/features/feedback/data/data_source/feedback_remote_datasourse.dart';
import 'package:grad_ease/features/feedback/data/repository/feedback_repository_impl.dart';
import 'package:grad_ease/features/feedback/domain/repository/feedback_repository.dart';
import 'package:grad_ease/features/feedback/presentation/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:grad_ease/features/feeds/data/data_sourse/feed_post_remote_data_source.dart';
import 'package:grad_ease/features/feeds/data/repository/feed_post_repository_impl.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_reply_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/delete_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/dislike_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/get_replies_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/getall_feed_post_usecase.dart';
import 'package:grad_ease/features/feeds/domain/usecase/like_post_use_case.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/add_post_bloc/add_post_bloc_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feed_detail_bloc/feed_detail_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';
import 'package:grad_ease/features/home/presentation/bloc/student_home/student_home_bloc.dart';
import 'package:grad_ease/features/main/bloc/landing_page_bloc.dart';
import 'package:grad_ease/features/notes/data/data_source/notes_remote_data_source.dart';
import 'package:grad_ease/features/notes/data/repository/notes_repository_impl.dart';
import 'package:grad_ease/features/notes/domain/repository/notes_repository.dart';
import 'package:grad_ease/features/notes/domain/usecase/add_note_use_case.dart';
import 'package:grad_ease/features/notes/domain/usecase/delete_note_use_case.dart';
import 'package:grad_ease/features/notes/domain/usecase/get_all_notes_use_case.dart';
import 'package:grad_ease/features/notes/presentation/bloc/add_note_bloc/add_note_bloc_bloc.dart';
import 'package:grad_ease/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:grad_ease/features/profile/data/data_source/profile_remote_repository.dart';
import 'package:grad_ease/features/profile/data/repository/profile_repository_impl.dart';
import 'package:grad_ease/features/profile/domain/repository/profile_repository.dart';
import 'package:grad_ease/features/profile/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:grad_ease/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:grad_ease/features/timetable/data/data_source/time_table_remote_data_source.dart';
import 'package:grad_ease/features/timetable/data/repository/time_table_repository_impl.dart';
import 'package:grad_ease/features/timetable/domain/repository/time_table_repository.dart';
import 'package:grad_ease/features/timetable/domain/usecase/get_time_table_use_case.dart';
import 'package:grad_ease/features/timetable/presentation/bloc/time_table_bloc/time_table_bloc.dart';
import 'package:grad_ease/features/uucms/data/data_sourse/uccm_remote_data_source.dart';
import 'package:grad_ease/features/uucms/data/repository/uucms_repository_impl.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_attendance_info_bloc/uucms_attendance_info_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_internal_info_bloc/uucms_internal_marks_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_registered_course_bloc/uucms_registered_course_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_result_info_bloc/uucms_result_bloc.dart';
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
        () => FeedPostRemoteDataSourceImpl())
    ..registerFactory<CommunityRemoteDataSource>(
        () => CommunityRemoteDataSourceImpl())
    ..registerFactory<NoteRemoteDataSource>(() => NotesRemoteDataSourceImpl())
    ..registerFactory<TimeTableRemoteDataSource>(
        () => TimeTableRemoteDataSourceImpl())
    ..registerFactory<UUCMSRemoteDataSource>(() => UUCMSRemoteDataSourceImpl())
    ..registerFactory<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl())
    ..registerFactory<AdminRemoteDataSource>(() => AdminRemoteDataSourceImpl())
    ..registerFactory<AssignmentRemoteDataSource>(
        () => AssignmentRemoteDataSourceImpl())
    ..registerFactory<FeedbackRemoteDataSourse>(
        () => FeedbackRemoteDataSourceImpl());
}

void _registerRepositories() {
  serviceLocator
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          authLocalDataSource: serviceLocator(),
        ))
    ..registerFactory<FeedPostRepository>(
        () => FeedPostRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<CommunityRepository>(
        () => CommunityRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<NotesRepository>(
        () => NotesRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<TimeTableRepository>(
        () => TimeTableRepositortImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<UUCMSRepository>(
        () => UUCMSRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<AdminRepository>(
        () => AdminRepositoryIml(serviceLocator(), serviceLocator()))
    ..registerFactory<ProfileRepository>(
        () => ProfileRepositoryIml(serviceLocator(), serviceLocator()))
    ..registerFactory<AssignmentRepository>(
        () => AssignmentRepositoryImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<FeedbackRepository>(
        () => FeedbackRepositoryImpl(serviceLocator(), serviceLocator()));
}

void _registerUseCases() {
  serviceLocator
    ..registerFactory(
        () => StudentLoginUseCase(serviceLocator(), serviceLocator()))
    ..registerFactory(() => GetAllFeedPostUseCase(serviceLocator()))
    ..registerFactory(() => GetRepliesUseCase(serviceLocator()))
    ..registerFactory(() => AddReplyUseCase(serviceLocator()))
    ..registerFactory(() => AddPostUseCase(serviceLocator()))
    ..registerFactory(() => LikePostUseCase(serviceLocator()))
    ..registerFactory(() => DislikePostUseCase(serviceLocator()))
    ..registerFactory(() => DeletePostUseCase(serviceLocator()))
    ..registerFactory(() => GetCommunityUseCase(serviceLocator()))
    ..registerFactory(() => GetCommunityMessagesUseCase(serviceLocator()))
    ..registerFactory(() => SendMessageUseCase(serviceLocator()))
    ..registerFactory(() => GetAllNotesUseCase(serviceLocator()))
    ..registerFactory(() => AddNewNoteUseCase(serviceLocator()))
    ..registerFactory(() => DeleteNoteUseCase(serviceLocator()))
    ..registerFactory(() => GetTimeTableUseCase(serviceLocator()))
    ..registerFactory(() => RegisterStudentUseCase(serviceLocator()))
    ..registerFactory(
        () => AdminLoginUseCase(serviceLocator(), serviceLocator()));
}

void _registerBlocs() {
  serviceLocator
    ..registerLazySingleton(() => AuthBloc(
          studentLoginUseCase: serviceLocator(),
          appUserCubit: serviceLocator(),
          adminLoginUseCase: serviceLocator(),
          registerStudentUseCase: serviceLocator(),
        ))
    ..registerLazySingleton(() => LandingPageBloc())
    ..registerLazySingleton(() => FeedPostBloc(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerLazySingleton(() => FeedDetailBloc(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerLazySingleton(() => StudentsBloc(serviceLocator()))
    ..registerLazySingleton(() => AddPostBloc(serviceLocator()))
    ..registerLazySingleton(() => CommunityBloc(serviceLocator()))
    ..registerLazySingleton(() => NotesBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() => AddNoteBloc(serviceLocator()))
    ..registerLazySingleton(
        () => CommunityDetailBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() => TimeTableBloc(serviceLocator()))
    ..registerLazySingleton(() => UUCMSBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(
        () => UUCMSInternalMarksBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(
        () => UUCMSRegisteredCourseBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() => UUCMSAttendanceInfoBloc(serviceLocator()))
    ..registerLazySingleton(
        () => UUCMSExamResultBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() => TimetableBloc(serviceLocator()))
    ..registerLazySingleton(() => AddTimetableBloc(serviceLocator()))
    ..registerLazySingleton(() => CommunitesBloc(serviceLocator()))
    ..registerLazySingleton(() => AddCommunityBloc(serviceLocator()))
    ..registerLazySingleton(() => AdminBloc(serviceLocator()))
    ..registerLazySingleton(() => ProfileBloc(serviceLocator()))
    ..registerLazySingleton(() => EditUserBloc(serviceLocator()))
    ..registerLazySingleton(() =>
        StudentHomeBloc(serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerLazySingleton(
        () => EditProfileBloc(serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() => AssignmentBloc(serviceLocator()))
    ..registerLazySingleton(() => AdminAssignmnetBloc(serviceLocator()))
    ..registerLazySingleton(() => UpsertAssignmentBloc(serviceLocator()))
    ..registerLazySingleton(() => FeedbackBloc(serviceLocator()))
    ..registerLazySingleton(() => AdminFeedbackBloc(serviceLocator()));
}
