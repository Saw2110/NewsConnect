import 'package:flutter/material.dart';

class SnackbarHelper {
  const SnackbarHelper._();
  static SnackBar show({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return SnackBar(
      content: Text(message, style: textStyle),
      duration: duration,
      action: action,
      backgroundColor: backgroundColor,
    );
  }
}
