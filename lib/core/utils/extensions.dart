import 'package:flutter/material.dart';
import 'package:our_pass/core/core.dart';

extension Extras on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(
      message,
      color: appColors.red,
    );
  }

  void showSuccess(String message) {
    _showSnackBar(
      message,
      color: appColors.green,
    );
  }

  void showLoader(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Container(
          color: appColors.black.withAlpha(90),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
