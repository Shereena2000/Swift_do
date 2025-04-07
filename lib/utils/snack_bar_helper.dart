import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';

void showScaffoldMessage(BuildContext context, String message, ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: primaryColor,
    ),
  );
}
