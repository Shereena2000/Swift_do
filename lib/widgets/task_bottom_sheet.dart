import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/screens/home_screen/widgets/save_button.dart';
import 'package:swift_do/services/date_picker_helper.dart';
import 'package:swift_do/utils/constants.dart';
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
      child: SingleChildScrollView(  // Added SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the left
          children: [
            // Add a handle/indicator at the top of the bottom sheet
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            
            kheight20,
            
            // Task Name Input
            TaskInputField(
              controller: taskController,
              hint: "Enter task name",
              icon: Icons.check_circle_outline,
              maxLength: 30,
            ),
            
         kheight20,
            
            // Description Input
            TaskInputField(
              controller: descriptionController,
              hint: "Enter description",
              icon: Icons.insert_drive_file_outlined,
              maxLength: 90,
            ),
            
       kheight20,
            
            // Due Date Selection
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
            
         kheight30,
            
            // Submit Button
            Center(
              child: SaveBotton(
                onPressed: () {
                  if (taskController.text.trim().isNotEmpty) {
                    Provider.of<TodoProvider>(context, listen: false).addTodo(
                      title: taskController.text,
                      description: descriptionController.text,
                      dueDate: datePickerHelper.selectedDate,
                      context: context
                    );
                    Navigator.pop(context);
                  } else {
                    // Show error if task name is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task name cannot be empty'))
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}