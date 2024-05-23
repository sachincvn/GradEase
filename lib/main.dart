import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/app_theme.dart';
import 'package:grad_ease/features/admin/presentation/bloc/add_community/add_community_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/add_timetable/add_timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_bloc/admin_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/communites_bloc/communites_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/students_bloc/students_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/timetable_bloc/timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/admin_home_screen.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_bloc/community_bloc.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_detail/community_detail_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/add_post_bloc/add_post_bloc_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feed_detail_bloc/feed_detail_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';
import 'package:grad_ease/features/main/bloc/landing_page_bloc.dart';
import 'package:grad_ease/features/notes/presentation/bloc/add_note_bloc/add_note_bloc_bloc.dart';
import 'package:grad_ease/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:grad_ease/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:grad_ease/features/timetable/presentation/bloc/time_table_bloc/time_table_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_attendance_info_bloc/uucms_attendance_info_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_internal_info_bloc/uucms_internal_marks_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_registered_course_bloc/uucms_registered_course_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_result_info_bloc/uucms_result_bloc.dart';
import 'package:grad_ease/init_dependencies.dart';
import 'package:grad_ease/features/main/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<LandingPageBloc>()),
      BlocProvider(create: (_) => serviceLocator<FeedPostBloc>()),
      BlocProvider(create: (_) => serviceLocator<FeedDetailBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddPostBloc>()),
      BlocProvider(create: (_) => serviceLocator<CommunityBloc>()),
      BlocProvider(create: (_) => serviceLocator<CommunityDetailBloc>()),
      BlocProvider(create: (_) => serviceLocator<NotesBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddNoteBloc>()),
      BlocProvider(create: (_) => serviceLocator<TimeTableBloc>()),
      BlocProvider(create: (_) => serviceLocator<UUCMSBloc>()),
      BlocProvider(create: (_) => serviceLocator<UUCMSInternalMarksBloc>()),
      BlocProvider(create: (_) => serviceLocator<UUCMSAttendanceInfoBloc>()),
      BlocProvider(create: (_) => serviceLocator<UUCMSRegisteredCourseBloc>()),
      BlocProvider(create: (_) => serviceLocator<UUCMSExamResultBloc>()),
      BlocProvider(create: (_) => serviceLocator<StudentsBloc>()),
      BlocProvider(create: (_) => serviceLocator<TimetableBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddTimetableBloc>()),
      BlocProvider(create: (_) => serviceLocator<CommunitesBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddCommunityBloc>()),
      BlocProvider(create: (_) => serviceLocator<AdminBloc>()),
      BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, LoggedIn>(
        selector: (state) {
          if (state is AppUserLoggedIn) {
            return LoggedIn(isStudent: true, isAdmin: false);
          } else if (state is AppAdminLogedIn) {
            return LoggedIn(isStudent: false, isAdmin: true);
          } else {
            return LoggedIn(isStudent: false, isAdmin: false);
          }
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn.isAdmin) {
            return const AdminHomeScreen();
          } else if (isLoggedIn.isStudent) {
            return const LandingPage();
          } else {
            return const StudentLoginScreen();
          }
        },
      ),
    );
  }
}

class LoggedIn {
  final bool isAdmin;
  final bool isStudent;

  LoggedIn({this.isAdmin = false, this.isStudent = false});
}
