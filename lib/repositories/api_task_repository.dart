import 'dart:convert';

import 'package:todo_app/models/task.dart';
import 'package:todo_app/repositories/task_repository.dart';
import 'package:http/http.dart' as http;

class ApiTaskRepository extends TaskRepository {
  final String baseUrl = "http://localhost:3000";
  final headers = {'Content-Type': 'application/json'};
  @override
  Future<Task?> add(String title, String description) async {
    Task task = Task(
      id: "",
      title: title,
      description: description,
    );

    await http.post(
      Uri.parse("$baseUrl/tasks"),
      body: task.toMap(),
      headers: headers,
    );

    return task;
  }

  @override
  Future<Task> delete({required String id}) async {
    final List<Task> tasks = await get();

    Task task = tasks.where((element) => element.id == id).first;

    await http.delete(
      Uri.parse("$baseUrl/tasks/$id"),
      headers: headers,
    );

    return task;
  }

  @override
  Future<List<Task>> get() async {
    List<Task> tasks = [];
    final response = await http.get(
      Uri.parse("$baseUrl/tasks"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body.toString()); // Handle response
      for (Map<String, dynamic> index in decode) {
        tasks.add(Task.fromMap(index));
      }
      return tasks;
    } else {
      throw Exception(
        'Error when fetching data',
      );
    }
  }

  @override
  Future<Task> update({
    required String id,
    String? title,
    String? description,
    bool? isCompleted,
  }) async {
    final List<Task> tasks = await get();

    Task task = tasks.where((element) => element.id == id).first;

    task = task.copyWith(
      title: title ?? task.title,
      description: description ?? task.description,
      isCompleted: isCompleted ?? task.isCompleted,
    );

    await http.put(
      Uri.parse("$baseUrl/tasks/$id"),
      headers: headers,
      body: task.toMap(),
    );

    return task;
  }
}
