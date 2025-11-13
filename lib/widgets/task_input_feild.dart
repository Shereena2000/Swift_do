import 'package:flutter/material.dart';
import 'package:swift_do/utils/color_constants.dart';
import 'package:swift_do/utils/constants.dart';

class TaskInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLength;

  const TaskInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(color: Colors.grey.shade300, fontSize: 14)),

        Row(
          children: [
            Icon(icon, color:whiteColor, size: 30),
kwidth10,
            Expanded(
           
              child: TextField(
                controller: controller,
                maxLength: maxLength,
                style: TextStyle(color:whiteColor),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                 
                ),
              ),
            ),
          ],
        ),
        Divider(color: Colors.white70, thickness: 1),
      ],
    );
  }
}
