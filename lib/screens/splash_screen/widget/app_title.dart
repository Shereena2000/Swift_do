import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';

class AppTitle extends StatelessWidget {
  const AppTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Swift Do",
      style: TextStyle(
        color: onSurfaceColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }
}