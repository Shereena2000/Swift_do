import 'package:flutter/material.dart';

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
            Icon(icon, color: Colors.white, size: 30),

            Expanded(
              child: TextField(
                controller: controller,
                maxLength: maxLength,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "${controller.text.length}/$maxLength",
                  counterStyle: TextStyle(color: Colors.white70, fontSize: 12),
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
