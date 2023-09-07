import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';

import 'package:list_ease/pages/widgets/form_text_field.dart';
import 'package:list_ease/pages/widgets/show_category_dialog.dart';
import 'package:provider/provider.dart';

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
                Consumer<HomeProvider>(
                    builder: (context, _, __) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await homeProvider.selectDate(context);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.stopwatch,
                                    color: (homeProvider.datePicked != null &&
                                            homeProvider.timePicked != null)
                                        ? ColorApp.secondColor
                                        : ColorApp.primaryTextColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showCategoryDialog(context);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.tag,
                                    color: homeProvider.selectedCategory != null
                                        ? ColorApp.secondColor
                                        : ColorApp.primaryTextColor,
                                  ),
                                )
                              ],
                            ),
                            Consumer<MainProvider>(
                              builder: (context, mainProvider, _) => IconButton(
                                onPressed: () {
                                  mainProvider.changeShowBottomSheet =
                                      !mainProvider.showBottomSheet;
                                  homeProvider.insertToDos(
                                    homeProvider.selectedCategory!.id,
                                    homeProvider.titleController.text,
                                    homeProvider.descriptionController.text,
                                    homeProvider.datePicked ?? DateTime.now(),
                                    homeProvider.timePicked ?? "",
                                    
                                  );
                                  homeProvider.clear();

                                  // print(homeProvider.datePicked);
                                },
                                icon: const Icon(
                                  Ionicons.send_outline,
                                  color: ColorApp.secondColor,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
