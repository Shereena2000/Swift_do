import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(onSurfaceColor),
        strokeWidth: 3,
      ),
    );
  }
}