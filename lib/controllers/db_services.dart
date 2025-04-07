import 'package:cloud_firestore/cloud_firestore.dart';

class DbServices {
  final _fire = FirebaseFirestore.instance;
  Future<void>  add({required Map<String, dynamic> data})async {
    _fire.collection("Task").add(data);
  }

    Stream<QuerySnapshot> getTasksStream() {
    return _fire.collection("Task").snapshots();
  }
  Future<void> updateTask(String docId, Map<String, dynamic> updates) async {
    await _fire.collection("Task").doc(docId).update(updates);
  }

  // Delete a task
  Future<void> deleteTask(String docId) async {
    await _fire.collection("Task").doc(docId).delete();
  }
}
