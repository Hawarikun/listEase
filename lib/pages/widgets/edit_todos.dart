import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_page.dart';
import 'package:list_ease/pages/widgets/show_category_dialog.dart';
import 'package:list_ease/pages/widgets/show_edit_title_todos.dart';
import 'package:provider/provider.dart';

class EditToDos extends StatelessWidget {
  final ToDosWithCategory data;
  const EditToDos({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    DateTime now = DateTime.now();
    int day = now.day;
    int month = now.month;
    int year = now.year;
    DateTime currentDate = DateTime(year, month, day);

    TimeOfDay stringToTimeOfDay(String time) {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }

    if (homeProvider.title == null &&
        homeProvider.description == null &&
        homeProvider.selectedCategory == null &&
        homeProvider.currentDate == null &&
        homeProvider.timePicked == null &&
        homeProvider.currentTime == null &&
        homeProvider.isComplate == null &&
        homeProvider.formattedDate == null) {
      homeProvider.setTitle = data.toDos.title;
      homeProvider.setDescription = data.toDos.description;
      homeProvider.setSelectedCategory = data.category;
      homeProvider.setCurrentDate = data.toDos.date;
      homeProvider.setTimePicked = data.toDos.time;
      homeProvider.setCurrentTime = stringToTimeOfDay(homeProvider.timePicked!);
      homeProvider.setIsComplete = !data.toDos.isCompleted;
      homeProvider.setFormattedDate = data.toDos.date;
    }

    print(homeProvider.selectedCategory);
    print(homeProvider.isComplate);
    print("Build Ulang");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  homeProvider.clear();
                },
                icon: const Icon(
                  Ionicons.close_outline,
                  color: ColorApp.primaryTextColor,
                ),
              ),
              Consumer<HomeProvider>(
                builder: (context, _, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: homeProvider.isComplate ?? false,
                          onChanged: (value) {
                            print("Before update: ${homeProvider.isComplate}");
                            homeProvider.setIsComplete =
                                !(homeProvider.isComplate ?? false);
                            print("After update: ${homeProvider.isComplate}");
                          },
                          activeColor: ColorApp.secondColor,
                          shape: const CircleBorder(),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              homeProvider.title ?? "",
                              style: const TextStyle(
                                fontSize: 20,
                                color: ColorApp.primaryTextColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              homeProvider.description ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                color: ColorApp.borderColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showEditTitleTodos(data, context);
                      },
                      icon: const Icon(
                        Icons.edit_square,
                        color: ColorApp.primaryTextColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 38),
              Consumer<HomeProvider>(
                builder: (context, _, __) => listWidget(
                  context,
                  data,
                  Ionicons.time_outline,
                  "Task Time :",
                  homeProvider.currentDate == currentDate
                      ? "Today At ${homeProvider.timePicked}"
                      : "${homeProvider.formattedDate} At ${homeProvider.timePicked}",
                  iconContent: "",
                  onTap: () {
                    homeProvider.selectDate(context);
                  },
                ),
              ),
              const SizedBox(height: 34),
              Consumer<HomeProvider>(
                builder: (context, _, __) => listWidget(
                  context,
                  data,
                  CupertinoIcons.tag,
                  "Task Category :",
                  homeProvider.selectedCategory?.categoryName ?? "",
                  iconContent: homeProvider.selectedCategory?.icon ?? "",
                  onTap: () {
                    showCategoryDialog(context);
                  },
                ),
              ),
              const SizedBox(height: 29),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TextButton(
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Warning"),
                          content: const Text(
                              "Are you sure you want to delete this List ?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                homeProvider.database
                                    .deleteTodosRepo(data.toDos.id);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                                homeProvider.addCategoryClear();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(CupertinoIcons.delete, color: ColorApp.errorColor),
                      SizedBox(width: 10),
                      Text(
                        "Delete Category",
                        style:
                            TextStyle(fontSize: 16, color: ColorApp.errorColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton(
            backgroundColor: ColorApp.secondColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              if (homeProvider.title == null &&
                  homeProvider.description == null &&
                  homeProvider.selectedCategory == null &&
                  homeProvider.currentDate == null &&
                  homeProvider.timePicked == null &&
                  homeProvider.currentTime == null &&
                  homeProvider.isComplate == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Warning"),
                      content: const Text(
                          "Please fill in all fields before continuing."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Tutup dialog peringatan.
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                homeProvider.updateTodosTitle(
                  data.toDos.id,
                  homeProvider.selectedCategory?.id ?? 100,
                  homeProvider.titleController.text,
                  homeProvider.descriptionController.text,
                  homeProvider.datePicked ?? DateTime.now(),
                  homeProvider.timePicked ?? "",
                  homeProvider.isComplate ?? true,
                );
                Navigator.of(context).pop();
                homeProvider.clear();
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Edit Task",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorApp.primaryTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget listWidget(BuildContext context, ToDosWithCategory data, IconData icon,
    String title, String content,
    {String? iconContent, VoidCallback? onTap}) {
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  final colorString = homeProvider.selectedCategory?.color ?? "";
  Color color = Color(int.tryParse("0x$colorString") ?? 0);

  String unicodeValue = iconContent?.toUpperCase() ?? "";
  int codePoint = int.tryParse("0$unicodeValue", radix: 16) ?? 0;
  IconData iconCategory = IconData(
    codePoint,
    fontFamily: 'MaterialIcons',
  );

  return Padding(
    padding: const EdgeInsets.only(left: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: ColorApp.primaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: ColorApp.primaryTextColor,
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorApp.boxColor,
            ),
            child: Row(
              children: [
                (iconContent != "")
                    ? Row(
                        children: [
                          Icon(
                            iconCategory,
                            size: 18,
                            color: color,
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    : const SizedBox(),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorApp.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
