import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';

class SaveBotton extends StatelessWidget {
 final Function onPressed;
  const SaveBotton({
    super.key, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white),
        foregroundColor: onSurfaceColor,
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
      ),
      onPressed: () {
       onPressed();
      },
      child: Text("Save Task"),
    );
  }
}