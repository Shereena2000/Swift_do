import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/utils/color_constants.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSearching ? MediaQuery.of(context).size.width-20 : 48,
      height: 48,
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(24),
        color: _isSearching ? greyColor : Colors.transparent,
      ),
      child: Row(
        children: [
          // Search Icon Button
          IconButton(
            icon: Icon(_isSearching ? Icons.arrow_back : Icons.search, size: 24),
            onPressed: () {
              if (_isSearching) {
                // Clear search and collapse
                _searchController.clear();
                todoProvider.clearSearch();
                setState(() {
                  _isSearching = false;
                });
              } else {
                // Expand search bar
                setState(() {
                  _isSearching = true;
                });
              }
            },
          ),
          // Search TextField - only visible when searching
          if (_isSearching)
            Expanded(
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search tasks...',
                hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (value) {
                  todoProvider.setSearchQuery(value);
                },
              ),
            ),
        ],
      ),
    );
  }
}