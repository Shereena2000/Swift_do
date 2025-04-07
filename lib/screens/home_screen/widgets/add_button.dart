import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';
import 'package:swift_do/widgets/task_bottom_sheet.dart';


class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Show the bottom sheet properly
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => TaskBottomSheet(),
        );
      },
      backgroundColor: primaryColor, // Use ColorConstants
      shape: CircleBorder(),
      child: Icon(
        Icons.add,
        color: onSurfaceColor,
        size: 30,
      ), // Use ColorConstants
    );
  }
}

