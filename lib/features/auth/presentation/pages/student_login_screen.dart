import 'package:flutter/material.dart';
import 'package:grad_ease/core/extensions/spacing_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/auth/presentation/pages/admin_login_screen.dart';
import 'package:grad_ease/features/auth/presentation/widgets/auth_button.dart';
import 'package:grad_ease/features/auth/presentation/widgets/auth_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:page_transition/page_transition.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.topSpacing(12),
            ),
            Text(
              "Sign In",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            AuthInputField(
              labelText: "Email",
              hintText: "sachinchavan@gmail.com",
              controller: emailController,
            ),
            const SizedBox(height: 20),
            AuthInputField(
              labelText: "Password",
              hintText: "*********",
              controller: passwordController,
              isObscureText: true,
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            AuthButton(
              buttonText: "Sign In",
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const AdminLoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: context.topSpacing(20)),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Login to admin account?",
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
          ],
        ),
      ),
    );
  }
}
