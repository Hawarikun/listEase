import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/widgets/form_text_field.dart';
import 'package:provider/provider.dart';

void showEditTitleTodos(ToDosWithCategory data, BuildContext context) {
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);

  homeProvider.titleController.text = data.toDos.title;
  homeProvider.descriptionController.text = data.toDos.description;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: ColorApp.boxColor,
        title: const Text(
          "Edit Task Title",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: ColorApp.primaryTextColor,
          ),
        ),
        content: Column(
          children: [
            formTextField(homeProvider.titleController, "Title"),
            const SizedBox(height: 13),
            formTextField(homeProvider.descriptionController, "Description"),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 46),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cencel",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: ColorApp.secondColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 19),
            ),
            onPressed: () {
              if (homeProvider.titleController.text.isNotEmpty &&
                  homeProvider.descriptionController.text.isNotEmpty) {
                homeProvider.updateTitleDescription(
                  homeProvider.titleController.text,
                  homeProvider.descriptionController.text,
                );

                print(homeProvider.title);
                print(homeProvider.description);
                Navigator.of(context).pop();
              } else {
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
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 16, color: ColorApp.primaryTextColor),
            ),
          ),
        ],
      );
    },
  );
}
