import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final formatted = DateFormat("E, d MMM y").format(data.toDos.date);

    DateTime now = DateTime.now();
    int day = now.day;
    int month = now.month;
    int year = now.year;
    DateTime currentDate = DateTime(year, month, day);

    homeProvider.selectedCategory = data.category;

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
                },
                icon: const Icon(
                  Ionicons.close_outline,
                  color: ColorApp.primaryTextColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<HomeProvider>(
                        builder: (context, homeProvider, _) => Checkbox(
                          value: !data.toDos.isCompleted,
                          onChanged: (value) {
                            homeProvider.updateIsComplete(
                                data.toDos.id, !data.toDos.isCompleted);
                            print(data.toDos.isCompleted);
                          },
                          activeColor: ColorApp.secondColor,
                          shape: const CircleBorder(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            data.toDos.title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: ColorApp.primaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            data.toDos.description,
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
              const SizedBox(height: 38),
              listWidget(
                context,
                data,
                Ionicons.time_outline,
                "Task Time :",
                data.toDos.date == currentDate
                    ? "Today At ${data.toDos.time}"
                    : "$formatted At ${data.toDos.time}",
                iconContent: "",
              ),
              const SizedBox(height: 34),
              // GestureDetector(
              //   onTap: () {
              //     print("Tapped");
              //     showCategoryDialog(context);
              //   },
              listWidget(
                context,
                data,
                CupertinoIcons.tag,
                "Task Category :",
                data.category.categoryName,
                iconContent: data.category.icon,
                onTap: () {
                  showCategoryDialog(context);
                  print("Tapped");
                },
              ),
              // ),
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
                          title: const Text("Peringatan"),
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
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: ColorApp.secondColor,
            onPressed: () {},
            label: const Text(
              "Edit Task",
              style: TextStyle(
                fontSize: 16,
                color: ColorApp.primaryTextColor,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget listWidget(BuildContext context, ToDosWithCategory data, IconData icon,
    String title, String content,
    {String? iconContent, VoidCallback? onTap}) {

  final colorString = data.category.color;
  Color color = Color(int.parse("0x$colorString"));


  String unicodeValue = iconContent!.toUpperCase();
  int codePoint = int.parse("0$unicodeValue", radix: 16);
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
