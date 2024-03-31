import 'package:todo_app/models/task.dart';

abstract class TaskRepository {
  Future<Task?> add(String title, String description);
  Future<List<Task>> get();
  Future<Task> update({required String id, String? title, String? description, bool? isCompleted,});
  Future<Task> delete({required String id,});
}

