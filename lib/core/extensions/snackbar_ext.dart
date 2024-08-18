import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core.dart';

extension StringToastExtension on String {
  void showToast({required Color backgroundColor}) {
    Fluttertoast.showToast(
      msg: this,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  void successToast() {
    Fluttertoast.showToast(
      msg: this,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.green,
      textColor: Colors.white,
    );
  }

  void errorToast() {
    Fluttertoast.showToast(
      msg: this,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.red,
      textColor: Colors.white,
    );
  }
}
