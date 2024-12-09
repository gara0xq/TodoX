import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todox/controller/todo_controller.dart';
import 'package:todox/utils/colors.dart';
import 'package:todox/view/widgets/todo_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TodoController>();
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      body: GetBuilder<TodoController>(builder: (controller) {
        controller.fetchTodos();
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 230,
                color: primaryColor,
                child: Stack(
                  children: [
                    Positioned(
                      top: 90,
                      left: -230,
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 50,
                            color: Colors.white12,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -30,
                      right: -90,
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 40, color: Colors.white12),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "My Todo List",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150),
                    SizedBox(
                      height: (controller.incompletedTodos.length * 90) + 35,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, i) => Container(
                          width: double.infinity,
                          height: 0.7,
                          color: Colors.grey,
                        ),
                        itemCount: controller.incompletedTodos.length,
                        itemBuilder: (_, i) {
                          return TodoTile(
                            index: i,
                            todo: controller.incompletedTodos[i],
                            // title: controller.incompletedTodos[i].title,
                            isDone: controller.incompletedTodos[i].isDone,
                            isTop: i == 0 ? true : false,
                            isBottom:
                                i == controller.incompletedTodos.length - 1
                                    ? true
                                    : false,
                            // category: controller.incompletedTodos[i].category,
                            checkbox: Checkbox(
                              value: controller.incompletedTodos[i].isDone,
                              onChanged: (bool? value) {
                                controller.changeIsDone(
                                  value!,
                                  controller.incompletedTodos[i],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    controller.completedTodos.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.center,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: (controller.completedTodos.length * 90) + 35,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, i) => Container(
                          width: double.infinity,
                          height: 0.7,
                          color: Colors.grey,
                        ),
                        itemCount: controller.completedTodos.length,
                        itemBuilder: (_, i) {
                          return TodoTile(
                            index: i,
                            todo: controller.completedTodos[i],
                            // title: controller.completedTodos[i].title,
                            isDone: controller.completedTodos[i].isDone,
                            isTop: i == 0 ? true : false,
                            isBottom: i == controller.completedTodos.length - 1
                                ? true
                                : false,
                            // category: controller.completedTodos[i].category,
                            checkbox: Checkbox(
                              value: controller.completedTodos[i].isDone,
                              onChanged: (bool? value) {
                                controller.changeIsDone(
                                  value!,
                                  controller.completedTodos[i],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => Get.toNamed("/add_new_task"),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Add New Task",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
