import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/constant/dummy_data.dart';
import 'package:list_ease/models/category_model.dart';
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
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorApp.boxColor,
            title: const Text(
              'Choose Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.primaryTextColor),
            ),
            content: Consumer<HomeProvider>(
                builder: (context, homeProvider, _) => CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 90,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index == 0) {
                                return newCategory();
                              } else {
                                final category = dummyCategories[index - 1];
                                final isSelected =
                                    category == homeProvider.selectedCategory;

                                return GestureDetector(
                                  onTap: () {
                                    homeProvider.selectCategory(category);
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.blue.withAlpha(50)
                                          : null,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: containerCategory(category),
                                  ),
                                );
                              }
                            },
                            childCount: dummyCategories.length + 1,
                          ),
                        ),
                      ],
                    )),
            actions: <Widget>[
              Consumer<HomeProvider>(
                builder: (context, value, child) => TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: ColorApp.secondColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Add Category',
                    style: TextStyle(color: ColorApp.primaryTextColor),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

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
            height: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorApp.primaryTextColor,
                      ),
                    ),
                    Consumer<MainProvider>(
                      builder: (context, mainProvider, _) => IconButton(
                        onPressed: () {
                          mainProvider.changeShowBottomSheet =
                              !mainProvider.showBottomSheet;
                        },
                        icon: const Icon(
                          Ionicons.close_outline,
                          color: ColorApp.primaryTextColor,
                        ),
                      ),
                    )
                  ],
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
                    Row(children: [
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
                        onPressed: () {
                          _showDialog();
                        },
                        icon: const Icon(
                          CupertinoIcons.tag,
                          color: ColorApp.primaryTextColor,
                        ),
                      )
                    ]),
                    Consumer<MainProvider>(
                      builder: (context, mainProvider, _) => IconButton(
                        onPressed: () {
                          mainProvider.changeShowBottomSheet =
                              !mainProvider.showBottomSheet;
                          homeProvider.clear();

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

Widget newCategory() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorApp.secondColor.withAlpha(50),
        ),
        child: const Icon(
          Ionicons.add,
          color: ColorApp.secondColor,
        ),
      ),
      const SizedBox(height: 5),
      const Text(
        "Create New",
        style: TextStyle(color: ColorApp.primaryTextColor),
      )
    ],
  );
}

Widget containerCategory(CategoryModel data) {
  final iconString = data.icon;
  final icon = IconData(int.parse(iconString.substring(2), radix: 16),
      fontFamily: 'MaterialIcons');
  final colorString = data.color;
  Color colorOrignal =
      Color(int.parse(colorString.replaceAll('#', '0x'))).withAlpha(255);
  Color color = colorOrignal.withOpacity(150 / 255);
  int alpha = 50;
  Color colorOpacyty =
      Color(int.parse(colorString.replaceAll('#', '0x'))).withAlpha(alpha);

  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: colorOpacyty,
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        data.categoryName,
        style: const TextStyle(color: ColorApp.primaryTextColor),
      )
    ],
  );
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
