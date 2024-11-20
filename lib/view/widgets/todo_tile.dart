import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todox/controller/todo_controller.dart';
import 'package:todox/model/todo_model.dart';
import 'package:todox/view/screens/todo_screen.dart';
import 'package:todox/view/widgets/icon_details.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  // String title, category;
  TodoModel todo;
  Checkbox checkbox;
  int index;
  bool isDone, isBottom, isTop;
  TodoTile({
    super.key,
    // required this.title,
    required this.todo,
    required this.checkbox,
    required this.index,
    // this.category = "task",
    this.isBottom = false,
    this.isDone = false,
    this.isTop = false,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TodoController>();
    // log(todo.toMap().toString());
    return GestureDetector(
      onTap: () {
        Get.dialog(TodoScreen(
          todo: todo,
        ));
      },
      child: Dismissible(
        key: Key(controller.incompletedTodos[index].toMap().toString()),
        onDismissed: (direction) {
          // controller.incompletedTodos.removeAt(i);
          controller.deleteTodo(controller.incompletedTodos[index], index);
        },
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Container(
          height: 90,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: isDone
                ? const Color.fromARGB(120, 255, 255, 255)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: isTop ? const Radius.circular(15) : Radius.zero,
              topRight: isTop ? const Radius.circular(15) : Radius.zero,
              bottomLeft: isBottom ? const Radius.circular(15) : Radius.zero,
              bottomRight: isBottom ? const Radius.circular(15) : Radius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconDetails(
                isDone: isDone,
                category: todo.category,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: isDone ? Colors.black45 : Colors.black,
                  ),
                ),
              ),
              checkbox,
            ],
          ),
        ),
      ),
    );
  }
}
