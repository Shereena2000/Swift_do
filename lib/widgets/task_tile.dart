import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swift_do/model/todo_model.dart';
import 'package:swift_do/utils/color_constants.dart';

class TaskTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function(bool?) onToggle;
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(false);

  TaskTile({
    Key? key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpandedNotifier,
      builder: (context, isExpanded, _) {
        return Column(
          children: [
            _buildTaskRow(isExpanded),
            if (isExpanded) _buildExpandedContent(),
          ],
        );
      },
    );
  }

  Widget _buildTaskRow(bool isExpanded) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTaskContainer(),
        _buildExpandArrow(isExpanded),
      ],
    );
  }

  Widget _buildTaskContainer() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _buildCheckbox(),
              _buildTitle(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Checkbox(
        value: todo.isCompleted,
        onChanged: onToggle,
        activeColor: primaryColor,
        side: BorderSide(color: onSurfaceColor, width: 2),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Text(
        todo.title,
        style: TextStyle(
          fontSize: 15,
          color: whiteColor,
          decorationColor: whiteColor,
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDeleteButton(),
        _buildEditButton(),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: whiteColor,
        size: 20,
      ),
      onPressed: onDelete,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildEditButton() {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: whiteColor,
        size: 20,
      ),
      onPressed: onEdit,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildExpandArrow(bool isExpanded) {
    return InkWell(
      onTap: () => _isExpandedNotifier.value = !_isExpandedNotifier.value,
      child: Icon(
        isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
        color: whiteColor,
        size: 20,
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 30.0,
        bottom: 8.0,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDueDate(),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDate() {
    return Text(
      todo.dueDate != null
          ? DateFormat('MMM dd, yyyy').format(todo.dueDate!)
          : '',
      style: TextStyle(
        color: todo.dueDate?.isBefore(DateTime.now()) ?? false
            ? Colors.red
            : null,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      todo.description,
      style: TextStyle(color: whiteColor),
    );
  }
}