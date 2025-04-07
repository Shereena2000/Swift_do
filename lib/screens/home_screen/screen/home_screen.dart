import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/tab_controller_provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/screens/home_screen/widgets/add_button.dart';
import 'package:swift_do/screens/home_screen/widgets/task_section.dart';
import 'package:swift_do/widgets/custom_nav_bar.dart';
import 'package:swift_do/utils/color_constants.dart';
import 'package:swift_do/widgets/search_bar_widget.dart';
import 'package:swift_do/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Initialize the tab controller when widget is created
    Provider.of<TabControllerProvider>(context, listen: false)
      .initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const _HomeScreenBody(),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: const AddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final isSearchActive = todoProvider.searchQuery.isNotEmpty;

    return AppBar(
      title: isSearchActive ? const Text(AppStrings.searchResults) : null,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: SearchBarWidget(),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: _HomeScreenTabBar(),
        ),
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final tabController = Provider.of<TabControllerProvider>(context).controller;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TabBarView(
          controller: tabController,
          children: const [
            TaskList(tabName: AppStrings.allItems),
            TaskList(tabName: AppStrings.pending),
            TaskList(tabName: AppStrings.completed),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenTabBar extends StatelessWidget {
  const _HomeScreenTabBar();

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