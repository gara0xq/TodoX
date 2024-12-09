import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todox/controller/todo_controller.dart';
import 'package:todox/view/widgets/icon_details.dart';

import '../../../utils/colors.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final _key = GlobalKey<FormState>();
  AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TodoController>();
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      body: GetBuilder<TodoController>(builder: (controller) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 100,
                color: primaryColor,
                child: Stack(
                  children: [
                    Positioned(
                      top: -60,
                      left: -220,
                      child: Container(
                        height: 380,
                        width: 380,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 50, color: Colors.white12),
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
                      child: const Text(
                        "Add New Task",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 55,
                          width: 55,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),
                    const Text(
                      "Task Title",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) =>
                            value != "" ? null : "Enter Title For Task",
                        decoration: const InputDecoration(
                          hintText: 'Task Title',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.selectCategory(0),
                            child: IconDetails(
                              category: 'task',
                              border: Border.all(
                                  width: 3,
                                  color: controller.selectedCategory == 0
                                      ? primaryColor
                                      : Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.selectCategory(1),
                            child: IconDetails(
                              category: 'achieve',
                              border: Border.all(
                                  width: 3,
                                  color: controller.selectedCategory == 1
                                      ? primaryColor
                                      : Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.selectCategory(2),
                            child: IconDetails(
                              category: 'event',
                              border: Border.all(
                                  width: 3,
                                  color: controller.selectedCategory == 2
                                      ? primaryColor
                                      : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  controller: _dateController,
                                  decoration: const InputDecoration(
                                    hintText: 'Date',
                                    suffixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  readOnly: true,
                                  onTap: () => controller.selectDate(
                                      context, _dateController),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Due Time",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  controller: _timeController,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: 'Due Time',
                                    suffixIcon: Icon(Icons.access_time),
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  readOnly: true,
                                  onTap: () => controller.selectTime(
                                      context, _timeController),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Note",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: _notesController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Notes',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (_key.currentState!.validate()) {
                    controller.onSaveTodo(
                      _titleController.text,
                      _notesController.text,
                      _dateController.text,
                      _timeController.text,
                    );

                    _titleController.clear();
                    _notesController.clear();
                    _dateController.clear();
                    _timeController.clear();
                    Get.back();
                  }
                },
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
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
