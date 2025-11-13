import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/tab_controller_provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/screens/home_screen/widgets/add_button.dart';
import 'package:swift_do/screens/home_screen/widgets/home_screen_body.dart';
import 'package:swift_do/screens/home_screen/widgets/home_screen_tab_bar.dart';
import 'package:swift_do/widgets/custom_nav_bar.dart';
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
      body: const HomeScreenBody(),
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
          child: HomeScreenTabBar(),
        ),
      ),
    );
  }
}



