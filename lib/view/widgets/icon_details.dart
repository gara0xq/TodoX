import 'package:flutter/material.dart';
import 'package:todox/utils/colors.dart';

// ignore: must_be_immutable
class IconDetails extends StatelessWidget {
  String category;
  Border? border = Border.all();
  bool isDone;
  IconDetails(
      {super.key, this.isDone = false, this.category = "task", this.border});

  String icon = "assets/icons/";

  @override
  Widget build(BuildContext context) {
    icon = "$icon$category.png";
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: border,
        color: !isDone
            ? category == "task"
                ? taskForignColor
                : category == "achieve"
                    ? achieveForignColor
                    : category == "event"
                        ? eventForignColor
                        : Colors.white
            : category == "task"
                ? const Color.fromARGB(100, 219, 236, 246)
                : category == "achieve"
                    ? const Color.fromARGB(100, 254, 245, 211)
                    : category == "event"
                        ? const Color.fromARGB(100, 231, 226, 243)
                        : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        icon,
        scale: 10,
        opacity: AlwaysStoppedAnimation(isDone ? 0.2 : 1),
      ),
    );
  }
}
