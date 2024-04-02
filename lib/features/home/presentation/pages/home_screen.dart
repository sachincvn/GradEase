import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:grad_ease/features/auth/presentation/widgets/auth_button.dart';
import 'package:grad_ease/init_dependencies.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authLocalDataSource = AuthLocalDataSourceImpl(serviceLocator());
    return Scaffold(
      appBar: AppBar(title: const Text("GradEase")),
      body: Column(
        children: [
          const Spacer(),
          const Text("Welcome"),
          AuthButton(
              buttonText: "Logout",
              onPressed: () {
                _authLocalDataSource.clearLoginCredientials();
                context.read<AppUserCubit>().updateUser(null);
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const StudentLoginScreen(),
                  ),
                  (route) => false,
                );
              }),
          const Spacer(),
        ],
      ),
    );
  }
}
