import 'package:flutter/material.dart';

import '../utils/snackbar_helper.dart';

extension SnackBar on BuildContext {
  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackbarHelper.show(message: message),
    );
  }
}
