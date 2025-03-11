import 'package:flutter/material.dart';

extension NumWidgetExtension<T> on num {
  Widget get sw => SizedBox(width: toDouble());
  Widget get sh => SizedBox(height: toDouble());
}

extension NumDimensionExtension<T> on num {
  Radius get r => Radius.circular(toDouble());
}
