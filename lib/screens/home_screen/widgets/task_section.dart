import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/model/todo_model.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/services/date_picker_helper.dart';
import 'package:swift_do/utils/color_constants.dart';
import 'package:swift_do/widgets/task_input_feild.dart';
import 'package:swift_do/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final String tabName;
  
  const TaskList({
    super.key, 
    required this.tabName
  });

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    
    if (todoProvider.isLoading) {
      return _buildLoadingIndicator();
    }

    final filteredTodos = _getFilteredTodos(todoProvider);
    
    if (filteredTodos.isEmpty) {
      return _buildEmptyState(todoProvider);
    }

    return _buildTaskList(todoProvider, filteredTodos);
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator()
    );
  }

  List<TodoModel> _getFilteredTodos(TodoProvider todoProvider) {
    final baseFilteredTodos = todoProvider.filteredTodos;

    switch (tabName) {
      case "Pending":
        return baseFilteredTodos.where((todo) => !todo.isCompleted).toList();
      case "Completed":
        return baseFilteredTodos.where((todo) => todo.isCompleted).toList();
      default:
        return baseFilteredTodos;
    }
  }

  Widget _buildEmptyState(TodoProvider todoProvider) {
    final animationAsset = todoProvider.searchQuery.isNotEmpty
        ? "assets/empty_search.json"
        : "assets/empty.json";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 300,
            child: Lottie.asset(animationAsset),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(TodoProvider todoProvider, List<TodoModel> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TaskTile(
          todo: todo,
          onDelete: () => todoProvider.deleteTodo(todo.id),
          onEdit: () => _showEditDialog(context, todo, todoProvider),
          onToggle: (_) => todoProvider.toggleTodoCompletion(
            todo.id, 
            todo.isCompleted
          ),
        );
      },
    );
  }

  void _showEditDialog(
    BuildContext context,
    TodoModel todo,
    TodoProvider provider,
  ) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);
    final datePickerHelper = DatePickerHelper();

    if (todo.dueDate != null) {
      datePickerHelper.setSelectedDate(todo.dueDate);
    }

    showDialog(
      context: context,
      builder: (context) => _buildEditDialog(
        context,
        titleController,
        descriptionController,
        datePickerHelper,
        todo,
        provider,
      ),
    );
  }

  Widget _buildEditDialog(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController,
    DatePickerHelper datePickerHelper,
    TodoModel todo,
    TodoProvider provider,
  ) {
    return AlertDialog(
      backgroundColor: primaryColor,
      title: const Text(
        'Edit Task',
        style: TextStyle(color: onSurfaceColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskInputField(
            controller: titleController,
            hint: "Enter task name",
            icon: Icons.check_circle_outline,
            maxLength: 30,
          ),
          const SizedBox(height: 20),
          TaskInputField(
            controller: descriptionController,
            hint: "Enter description",
            icon: Icons.insert_drive_file_outlined,
            maxLength: 90,
          ),
          _buildDatePicker(datePickerHelper),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: whiteColor),
          ),
        ),
        TextButton(
          onPressed: () => _saveTodoChanges(
            context,
            provider,
            todo.id,
            titleController,
            descriptionController,
            datePickerHelper,
          ),
          child: const Text(
            'Save', 
            style: TextStyle(color: whiteColor),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(DatePickerHelper datePickerHelper) {
    return ListenableBuilder(
      listenable: datePickerHelper,
      builder: (context, _) {
        return Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 10),
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
                icon: const Icon(
                  Icons.close,
                  color: Colors.white70,
                  size: 20,
                ),
                onPressed: datePickerHelper.clearDate,
              ),
          ],
        );
      },
    );
  }

  Future<void> _saveTodoChanges(
    BuildContext context,
    TodoProvider provider,
    String id,
    TextEditingController titleController,
    TextEditingController descriptionController,
    DatePickerHelper datePickerHelper,
  ) async {
    await provider.updateTodo(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      dueDate: datePickerHelper.selectedDate,
      context: context,
    );
    Navigator.pop(context);
  }
}