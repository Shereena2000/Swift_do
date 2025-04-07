import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String title;
  String description;
  final DateTime? dueDate;
  bool isCompleted;
  TodoModel(
    this.dueDate, {
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
    map['dueDate'] != null ? (map['dueDate'] as Timestamp).toDate() : null,
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
