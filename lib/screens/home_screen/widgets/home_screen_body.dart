import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/tab_controller_provider.dart';
import 'package:swift_do/screens/home_screen/widgets/task_section.dart';
import 'package:swift_do/utils/app_strings.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody();

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