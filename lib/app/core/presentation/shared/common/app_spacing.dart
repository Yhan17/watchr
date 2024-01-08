import 'package:flutter/material.dart';

class AppSpacing extends SizedBox {
  const AppSpacing({
    Key? key,
    double width = 0.0,
    double height = 0.0,
  }) : super(
          key: key,
          width: width,
          height: height,
        );

  factory AppSpacing.horizontal(double width) => AppSpacing(
        width: width,
      );

  factory AppSpacing.vertical(double height) => AppSpacing(
        height: height,
      );
}
