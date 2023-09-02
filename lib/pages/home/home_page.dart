import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
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

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) => SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              color: ColorApp.boxColor,
            ),
            padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Add Task",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorApp.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 14),
                formTextField(homeProvider.titleController, "Title"),
                const SizedBox(height: 13),
                formTextField(
                    homeProvider.descriptionController, "Description"),
                const SizedBox(height: 19),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(children: [
                        IconButton(
                          onPressed: () async {
                            await homeProvider.selectDate(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.stopwatch,
                            color: ColorApp.primaryTextColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.tag,
                            color: ColorApp.primaryTextColor,
                          ),
                        )
                      ]),
                    ),
                    Consumer<MainProvider>(
                      builder: (context, mainProvider, _) => IconButton(
                        onPressed: () {
                          mainProvider.changeShowBottomSheet =
                              !mainProvider.showBottomSheet;
                          homeProvider.titleController.clear();
                          homeProvider.datePicked = "";
                          homeProvider.timePicked = "";

                          print(homeProvider.datePicked);
                        },
                        icon: const Icon(
                          Ionicons.send_outline,
                          color: ColorApp.secondColor,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget formTextField(TextEditingController controller, String hintText) {
  return TextField(
    scrollPadding: const EdgeInsets.all(0),
    controller: controller,
    style: const TextStyle(fontSize: 18, color: ColorApp.borderColor),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 18, color: ColorApp.borderColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      isDense: true,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorApp.borderColor,
        ),
      ),
    ),
  );
}
