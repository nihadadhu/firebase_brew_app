import 'package:cloud_firestore/cloud_firestore.dart';

class ToDOTaskService {

  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  /// Add a new task
  Future<void> addTask(String title) async {
    await _taskCollection.add({
      'title': title,
      'isComplete': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get tasks stream
  Stream<QuerySnapshot> getTasks() {
    return _taskCollection
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Toggle complete
  Future<void> toggleComplete(String id, bool value) async {
    await _taskCollection.doc(id).update({
      'isComplete': value,
    });
  }
  /// Update task
  Future<void> updateTask(String taskId, String newTitle, String description) async {
  await _taskCollection.doc(taskId).update({
    'title': newTitle,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}


  /// Delete
  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }
}