import 'package:flutter/material.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/extensions/spacing_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
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
            ),
            const SizedBox(height: 20),
            GradEaseInputField(
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
            GradEaseButton(
              buttonText: "Sign In",
              onPressed: () {},
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
        ),
      ),
    );
  }
}
