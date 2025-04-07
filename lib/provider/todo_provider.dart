import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swift_do/controllers/db_services.dart';
import 'package:swift_do/model/todo_model.dart';
import 'package:swift_do/utils/snack_bar_helper.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  String _searchQuery = '';

  // Getters
  List<TodoModel> get todos => _todos;
  String get searchQuery => _searchQuery;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final DbServices _dbServices = DbServices();
  
  // Filtered todos based on search query
  List<TodoModel> get filteredTodos {
    if (_searchQuery.isEmpty) {
      return _todos;
    }
    return _todos.where((todo) {
 return todo.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
   
  }
  
  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
  
  // Clear search
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }
  
  void initialize() {
    _loadTodos();
  }
  
  // Load todos from Firestore
  Future<void> _loadTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _dbServices.getTasksStream().listen((querySnapshot) {
        _todos = querySnapshot.docs.map((doc) {
          return TodoModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id, // Include the document ID
          });
        }).toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error loading todos: $e');
    }
  }

  Future<void> addTodo({
    required String title,
    required String description, DateTime? dueDate,required BuildContext context
  }) async {
    try {
      // Create a new todo model
      final newTodo = TodoModel(
            dueDate,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,

        isCompleted: false,
      );

      // Add to database - Use the instance variable, not create a new one
      await _dbServices.add(data: newTodo.toMap());
      showScaffoldMessage(context,"Todo added successfully" );
    } catch (e) {
      // Handle error
      print('Error adding todo: $e');
    }
  }
  
  Future<void> updateTodo({
    required String id,
    required String title,
    required String description,
     DateTime? dueDate,
     required BuildContext context
  }) async {
    try {
      await _dbServices.updateTask(id, {
        'title': title,
        'description': description,
         'dueDate': dueDate != null ? Timestamp.fromDate(dueDate) : null,
      });
        showScaffoldMessage(context,"Todo updated successfully" );
    } catch (e) {
      print('Error updating todo: $e');
      rethrow;
    }
  }

  // Delete a todo
  Future<void> deleteTodo(String id,) async {
    try {
      await _dbServices.deleteTask(id);
    } catch (e) {
      print('Error deleting todo: $e');
      rethrow;
    }
  }
  
  // Toggle completion status - optimistic update approach
  Future<void> toggleTodoCompletion(String id, bool currentStatus) async {
    try {
      // First, find and update the task in the local list (optimistic update)
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        // Create a new model with the toggled status
        final updatedTodo = TodoModel(    _todos[index].dueDate,
          id: _todos[index].id,
          title: _todos[index].title,
          description: _todos[index].description,
       
          isCompleted: !currentStatus, // Toggle the status
        );
        
        // Update the local list
        _todos[index] = updatedTodo;
        notifyListeners(); // Update UI immediately
      }
      
      // Then update in Firestore
      await _dbServices.updateTask(id, {'isCompleted': !currentStatus});
    } catch (e) {
      // If there's an error, revert the optimistic update
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final revertedTodo = TodoModel(
          _todos[index].dueDate,
          id: _todos[index].id,
          title: _todos[index].title,
          description: _todos[index].description,
       
          isCompleted: currentStatus, // Revert to original status
        );
        
        _todos[index] = revertedTodo;
        notifyListeners();
      }
      print('Error updating todo completion: $e');
      rethrow;
    }
  }
}