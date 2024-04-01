import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/app_theme.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:grad_ease/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
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
