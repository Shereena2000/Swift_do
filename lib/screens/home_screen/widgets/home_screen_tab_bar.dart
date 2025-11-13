import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/tab_controller_provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/utils/app_strings.dart';
import 'package:swift_do/utils/color_constants.dart';

class HomeScreenTabBar extends StatelessWidget {
  const HomeScreenTabBar();

  @override
  Widget build(BuildContext context) {
    final tabController = Provider.of<TabControllerProvider>(context).controller;
    final todoProvider = Provider.of<TodoProvider>(context);
    final filteredTodos = todoProvider.filteredTodos;

    final pendingCount = filteredTodos.where((todo) => !todo.isCompleted).length;
    final completedCount = filteredTodos.where((todo) => todo.isCompleted).length;

    return TabBar(
      controller: tabController,
      isScrollable: true,
      labelColor: onSurfaceColor,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: onSurfaceColor),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
      dividerColor: Colors.transparent,
      tabs: [
        const Tab(text: AppStrings.allItems),
        Tab(text: '${AppStrings.pending} ($pendingCount)'),
        Tab(text: '${AppStrings.completed} ($completedCount)'),
      ],
    );
  }
}