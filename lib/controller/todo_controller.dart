import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todox/model/todo_model.dart';
import 'package:todox/services/database_helper.dart';

class TodoController extends GetxController {
  late DatabaseHelper dbHelper;
  @override
  void onInit() async {
    dbHelper = DatabaseHelper();
    fetchTodos();

    super.onInit();
  }

  List<TodoModel> todos = [];

  List<TodoModel> _completedTodos = [];
  List<TodoModel> _incompletedTodos = [];

  List<TodoModel> get completedTodos => _completedTodos;
  List<TodoModel> get incompletedTodos => _incompletedTodos;

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;
  fetchTodos() async {
    // Fetch ToDos
    todos = await dbHelper.fetchToDos();
    _completedTodos = todos.where((element) => element.isDone).toList();
    _incompletedTodos = todos.where((element) => !element.isDone).toList();
    update();
  }

  changeIsDone(bool value, TodoModel todo) async {
    TodoModel updatedTodo = todo;
    updatedTodo.isDone = value;
    await dbHelper.updateToDo(updatedTodo);
    update();
  }

  selectCategory(int value) {
    _selectedCategory = value;
    update();
  }

  // Function to show the date picker
  Future<void> selectDate(context, dateController) async {
    DateTime? pickedDate = await showDatePicker(
      helpText: "helklo",
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
    update();
  }

  Future<void> selectTime(context, timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      helpText: "",
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      timeController.text = DateFormat('hh:mm a').format(selectedTime);
    }
  }

  onSaveTodo(title, description, dueDate, dueTime) async {
    String? category;
    _selectedCategory == 0
        ? category = "task"
        : _selectedCategory == 1
            ? category = "achieve"
            : _selectedCategory == 2
                ? "event"
                : null;

    await dbHelper.addToDo(
      TodoModel(
        title: title,
        description: description,
        category: category!,
        dueDateTime:
            DateFormat('yyyy-MM-dd hh:mm a').parse("$dueDate $dueTime"),
      ),
    );
    fetchTodos();
    update();
  }

  deleteTodo(TodoModel todo, int index) async {
    incompletedTodos.removeAt(index);
    await dbHelper.deleteToDo(todo.id!);
    fetchTodos();
    update();
  }
}
