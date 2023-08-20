import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list,
                      size: 24,
                      color: ColorApp.primaryTextColor,
                    ),
                  ),
                  Text(
                    "Index",
                    style: TextStyle(
                        fontSize: 20, color: ColorApp.primaryTextColor),
                  ),
                  SizedBox(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(),
                  )
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset("assets/Checklist.png"),
                    Text(
                      "What do you want to do today?",
                      style: TextStyle(color: ColorApp.primaryTextColor),
                    ),
                    Text(
                      "Tap + to add your tasks",
                      style: TextStyle(color: ColorApp.primaryTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
