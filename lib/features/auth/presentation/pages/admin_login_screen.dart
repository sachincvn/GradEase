import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/extensions/spacing_extension.dart';
import 'package:grad_ease/core/extensions/string_validation_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/admin/presentation/pages/admin_home_screen.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showErrorSnackBar(context, state.message);
              } else if (state is AdminAuthSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const AdminHomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              if (state is AuthLoading) {}
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.topSpacing(12),
                  ),
                  Text(
                    "Admin Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 40),
                  GradEaseInputField(
                    labelText: "Email",
                    hintText: "sachinchavan@gmail.com",
                    controller: emailController,
                    validator: (value) {
                      if (!value!.isValidEmail()) {
                        return "Enter valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GradEaseInputField(
                    labelText: "Password",
                    hintText: "*********",
                    controller: passwordController,
                    isObscureText: true,
                    validator: (value) {
                      if (!value!.isValidPassword()) {
                        return "Enter valid paassword";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            activeColor: ColorPallete.blue500,
                          ),
                          Text(
                            "Remember me",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      GradientText(
                        'Forget password',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorPallete.blue500,
                            ),
                        colors: const [
                          ColorPallete.green500,
                          ColorPallete.blue500,
                          ColorPallete.blue700,
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GradEaseButton(
                    buttonText: "Sign In",
                    isLoading: isLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthAdminSignIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(height: context.topSpacing(20)),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: const StudentLoginScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Login to stucdent account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                          children: const [
                            TextSpan(text: " "),
                            TextSpan(
                              style: TextStyle(color: ColorPallete.blue500),
                              text: "Click here",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
