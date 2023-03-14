import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';

class CustomSnackBar {
  static void showError(
    BuildContext context, {
    required String error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
        ),
        backgroundColor: appColors.red,
      ),
    );
  }
}
