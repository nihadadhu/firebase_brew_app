import 'package:flutter/material.dart';
import 'package:demo_app/model/to_do_model.dart';
import 'package:demo_app/services/task_services.dart';

class TaskProvider with ChangeNotifier {
  final ToDOTaskService _service = ToDOTaskService();

  final List<ToDoModel> _tasks = [];

  List<ToDoModel> get tasks => List.unmodifiable(_tasks);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  TaskProvider() {
    _listenToTasks();
  }

  /// Listen to Firestore task stream
  void _listenToTasks() {
    _service.getTasks().listen((snapshot) {
      _tasks
        ..clear()
        ..addAll(
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return ToDoModel(
              id: doc.id,
              title: data['title'] ?? '',
              description: data['description'] ?? '',
              isComplete: data['isComplete'] ?? false,
            );
          }),
        );

      _isLoading = false; // ✅ ADD THIS
      notifyListeners();
    });
  }

  /// Add new task
  Future<void> addTask(String title,) async {
    try {
      await _service.addTask(title);
    } catch (e) {
      debugPrint('Add task error: $e');
    }
   
  }

  /// Update task
  Future<void> updateTask(ToDoModel task, String newTitle) async {
    try {
      await _service.updateTask(task.id, newTitle, task.description);
    } catch (e) {
      debugPrint('Update task error: $e');
    }
  }

  /// Toggle completion
  Future<void> toggleComplete(ToDoModel task, bool? value) async {
    try {
      await _service.toggleComplete(task.id, value ?? false);
    } catch (e) {
      debugPrint('Toggle error: $e');
    }
  }

  /// Delete task
  Future<void> deleteTask(String id) async {
    try {
      await _service.deleteTask(id);
    } catch (e) {
      debugPrint('Delete task error: $e');
    }
  }
}
