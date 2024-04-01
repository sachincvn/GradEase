import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/app_theme.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => AuthBloc(
              studentLoginUseCase: StudentLoginUseCase(AuthRepositoryImpl(
                  authRemoteDataSource: AuthRemoteDataSourceImpl()))))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      theme: AppTheme.darkThemeMode,
      home: const StudentLoginScreen(),
    );
  }
}
