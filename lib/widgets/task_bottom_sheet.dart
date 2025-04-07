import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/screens/home_screen/widgets/save_button.dart';
import 'package:swift_do/services/date_picker_helper.dart';
import 'package:swift_do/widgets/task_input_feild.dart';

class TaskBottomSheet extends StatelessWidget {
  TaskBottomSheet({super.key});

  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
 final DatePickerHelper datePickerHelper = DatePickerHelper(); 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Task Name Input
          TaskInputField(
            controller: taskController,
            hint: "Enter task name",
            icon: Icons.check_circle_outline,
            maxLength: 30,
          ),

          SizedBox(height: 20),

          // Description Input
          TaskInputField(
            controller: descriptionController,
            hint: "Enter description",
            icon: Icons.insert_drive_file_outlined,
            maxLength: 90,
          ),

          SizedBox(height: 20),
// Due Date Selection (Using ValueListenableBuilder)
        // In your TaskBottomSheet widget:
ListenableBuilder(
  listenable: datePickerHelper,
  builder: (context, _) {
    return Row(
      children: [
        Icon(Icons.calendar_today, color: Colors.white, size: 30),
        SizedBox(width: 10),
        TextButton(
          onPressed: () => datePickerHelper.pickDate(context),
          child: Text(
            datePickerHelper.formattedDate,
            style: TextStyle(
              color: datePickerHelper.selectedDate == null 
                  ? Colors.white70 
                  : Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        if (datePickerHelper.selectedDate != null)
          IconButton(
            icon: Icon(Icons.close, color: Colors.white70, size: 20),
            onPressed: datePickerHelper.clearDate,
          ),
      ],
    );
  },
),
   SizedBox(height: 20),
          // Submit Button
          SaveBotton(
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false).addTodo(
                title: taskController.text,
                description: descriptionController.text,
                dueDate: datePickerHelper.selectedDate,
                context: context
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// Task Input Field Widget
