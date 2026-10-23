import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/colors.dart';

class AppSnackBar {
  static void showError(BuildContext context, String message) =>
      _show(context, message, AppColors.errorColor);

  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, AppColors.successColor);

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
