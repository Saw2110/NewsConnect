import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get screenHeight => size.height;
  double get screenWidth => size.width;
}
