import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todox/controller/todo_controller.dart';
import 'package:todox/view/screens/add_todo_screen.dart';
import 'package:todox/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TodoController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      getPages: [
        GetPage(name: "/home", page: () => const HomeScreen()),
        GetPage(name: "/add_new_task", page: () => AddTodoScreen()),
      ],
    );
  }
}
