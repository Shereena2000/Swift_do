import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';

class AppTagline extends StatelessWidget {
  const AppTagline();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your tasks, faster than ever",
      style: TextStyle(
        color: onSurfaceColor.withOpacity(0.7),
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    );
  }
}