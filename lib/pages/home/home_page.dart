import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:list_ease/pages/widgets/custom_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.filter,
                      size: 24,
                      color: ColorApp.primaryTextColor,
                    ),
                  ),
                  const Text(
                    "Index",
                    style: TextStyle(
                        fontSize: 20, color: ColorApp.primaryTextColor),
                  ),
                  const SizedBox(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(),
                  )
                ],
              ),
              Expanded(
                child: Column(
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
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Consumer<MainProvider>(
        builder: (context, mainProvider, __) => mainProvider.showBottomSheet
            ? const CustomBottomSheet()
            : const SizedBox(),
      ),
    );
  }
}