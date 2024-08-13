import 'package:flutter/material.dart';

extension EmptyPadding on num {
  SizedBox get yGap => SizedBox(height: toDouble());
  SizedBox get xGap => SizedBox(width: toDouble());
}
