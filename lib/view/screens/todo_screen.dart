import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todox/model/todo_model.dart';

// ignore: must_be_immutable
class TodoScreen extends StatelessWidget {
  TodoModel todo;
  TodoScreen({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: height - 400,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Center(
                child: Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      DateFormat('hh:mm a').format(todo.dueDateTime!),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Icon(Icons.access_time),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(todo.dueDateTime!),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Icon(Icons.calendar_today),
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: todo.description == ""
                  ? const Center(
                      child: Text(
                        "No Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Text(
                      todo.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
