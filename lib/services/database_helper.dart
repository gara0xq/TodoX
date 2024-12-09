import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todox/model/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        dueDateTime INTEGER,
        isDone INTEGER
      )
    ''');
  }

  // Add a new ToDo
  Future<int> addToDo(TodoModel todo) async {
    Database db = await database;
    return await db.insert('todos', todo.toMap());
  }

  // Fetch all ToDos
  Future<List<TodoModel>> fetchToDos() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    // log(maps.toString());
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }

  // Update a ToDo
  Future<int> updateToDo(TodoModel todo) async {
    Database db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete a ToDo
  Future<int> deleteToDo(int id) async {
    Database db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
