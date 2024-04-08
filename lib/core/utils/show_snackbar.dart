import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

void showSnackBar(BuildContext context, String? content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content ?? "Something went wrong"),
      ),
    );
}

void showErrorSnackBar(BuildContext context, String? content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content ?? "Something went wrong",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: ColorPallete.errorColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      ),
    );
}
