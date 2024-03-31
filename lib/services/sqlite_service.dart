import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/repositories/task_repository.dart';

Database? _database;

class SqliteService extends TaskRepository {
  SqliteService() {
    initializeDB();
  }

  Future get database async {
    if (_database == null) return _database;
    _database = await initializeDB();
  }

  Future<Database> initializeDB() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'database.db');
    return await openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(
          """ CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            author TEXT NOT NULL,
            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            is_completed INTEGER NOT NULL DEFAULT 0
          )""",
        );
      },
      version: 1,
    );
  }

  @override
  Future<Task?> add(
    String title,
    String description,
  ) async {
    final database = await openDatabase('database.db');

    Task task = Task(
      id: "",
      title: title,
      description: description,
    );

    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return task;
  }

  @override
  Future<Task> delete({required String id}) async {
    final database = await openDatabase('database.db');

    final List<Task> tasks = await get();

    Task task = tasks.where((element) => element.id == id).first;

    await database.delete('tasks', where: 'id = ?', whereArgs: [id]);

    return task;
  }

  @override
  Future<List<Task>> get() async {
    final database = await openDatabase('database.db');

    final List<Map<String, dynamic>> maps = await database.query('tasks', orderBy: 'id');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<Task> update({
    required String id,
    String? title,
    String? description,
    bool? isCompleted,
  }) async {
    final database = await openDatabase('database.db');

    final List<Task> tasks = await get();

    Task task = tasks.where((element) => element.id == id).first;

    task = task.copyWith(
      title: title ?? task.title,
      description: description ?? task.description,
      isCompleted: isCompleted ?? task.isCompleted,
    );

    await database
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [id]);

    return task;
  }
}
