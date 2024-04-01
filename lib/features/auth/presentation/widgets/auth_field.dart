import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class AuthInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final bool isObscureText;
  const AuthInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.errorMessage,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 14, color: ColorPallete.grey500),
          ),
          validator: validator,
          obscureText: isObscureText,
          style: const TextStyle(
              fontSize: 14,
              color: ColorPallete.whiteColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
