class TodoModel {
  int? id;
  String title, description, category;
  DateTime? dueDateTime = DateTime.now();
  bool isDone;

  TodoModel({
    this.id,
    required this.title,
    this.description = "",
    this.category = "task",
    this.dueDateTime,
    this.isDone = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'dueDateTime': dueDateTime?.millisecondsSinceEpoch,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      dueDateTime: map['dueDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDateTime'])
          : null,
      isDone: map['isDone'] == 1,
    );
  }
}
