import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/Checklist.png"),
        const Text(
          "What do you want to do today?",
          style: TextStyle(color: ColorApp.primaryTextColor),
        ),
        const Text(
          "Tap + to add your tasks",
          style: TextStyle(color: ColorApp.primaryTextColor),
        ),
      ],
    );
  }
}
