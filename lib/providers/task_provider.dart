import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository taskRepository;
  List<Task> tasks = [];
  int get taskCompletedLength => taskCompleted.length;
  int get taskUncompletedLength => taskUncompleted.length;
  double get taskPercent => taskCompletedLength / tasks.length;
  List<Task> get taskCompleted =>
      tasks.where((element) => element.isCompleted == true).toList();
  List<Task> get taskUncompleted =>
      tasks.where((element) => element.isCompleted == false).toList();
  bool isLoading = true;

  TaskProvider({
    required this.taskRepository,
  }) {
    load();
  }

  void _addTask(Task Task) {
    !tasks.contains(Task) ? tasks.add(Task) : null;
    notifyListeners();
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    taskRepository.add(title, description).then((value) {
      value == null ? null : _addTask(value);
    });
    // notifyListeners();
  }

  void removeTask(String id) {
    tasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void switchState(String id) async {
    Task task = tasks.firstWhere((element) => element.id == id);
    task = await taskRepository.update(id: id, isCompleted: !task.isCompleted);

    tasks = tasks.map((e) => e.id == id ? task : e).toList();

    notifyListeners();
    // if (task.isCompleted == false) {
    // }
  }

  void complete(String id) async {
    Task task = tasks.firstWhere((element) => element.id == id);
    if (task.isCompleted == false) {
      task = await taskRepository.update(id: id, isCompleted: true);

      tasks = tasks.map((e) => e.id == id ? task : e).toList();

      notifyListeners();
    }
  }

  void delete(String id) async {
    Task task = tasks.firstWhere((element) => element.id == id);

    task = await taskRepository.delete(id: id);

    tasks = tasks..removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void notComplete(String id) async {
    Task task = tasks.firstWhere((element) => element.id == id);
    if (task.isCompleted == true) {
      task = await taskRepository.update(id: id, isCompleted: false);

      tasks = tasks.map((e) => e.id == id ? task : e).toList();

      notifyListeners();
    }
  }

  void load() {
    taskRepository.get().then((value) {
      tasks = value;
      isLoading = false;
      notifyListeners();
    });
  }
}
