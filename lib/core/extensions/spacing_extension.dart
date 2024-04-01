import 'package:flutter/material.dart';

extension SpacingExtension on BuildContext {
  double verticalSpacing(double percentage) {
    final Size screenSize = MediaQuery.of(this).size;
    return screenSize.height * percentage / 100;
  }

  double horizontalSpacing(double percentage) {
    final Size screenSize = MediaQuery.of(this).size;
    return screenSize.width * percentage / 100;
  }

  double topSpacing(double percentage) {
    final Size screenSize = MediaQuery.of(this).size;
    return screenSize.height * percentage / 100;
  }

  double bottomSpacing(double percentage) {
    final Size screenSize = MediaQuery.of(this).size;
    return screenSize.height * percentage / 100;
  }
}
