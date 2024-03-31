class Task {
  final String? id;
  final String title;
  final String description;
  final String author;
  late DateTime createdAt = DateTime.now();
  final bool isCompleted;

  Task({
    this.author = "Desiré",
    required this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
    this.isCompleted = false,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
  }

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'author': "Me",
      'created_at': createdAt.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toString(),
      // id: map['id'] as String,
      title: map['title'],
      description: map['description'],
      author: map['author'],
      isCompleted: map['is_completed'] == 0 ? false : true,
      createdAt: DateTime.tryParse(map['created_at']),
    );
  } 

  Task copyWith({
    String? author,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
