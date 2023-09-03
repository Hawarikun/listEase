import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/constant/dummy_data.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class AddCategories extends StatelessWidget {
  const AddCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    // final icon = homeProvider.icon;

    return Scaffold(
      backgroundColor: ColorApp.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create new category",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorApp.primaryTextColor),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Category name :",
                    style: TextStyle(
                        fontSize: 16, color: ColorApp.primaryTextColor),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    scrollPadding: const EdgeInsets.all(0),
                    controller: homeProvider.categoryController,
                    style: const TextStyle(
                        fontSize: 18, color: ColorApp.borderColor),
                    decoration: const InputDecoration(
                      hintText: "Category name",
                      hintStyle:
                          TextStyle(fontSize: 18, color: ColorApp.borderColor),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorApp.borderColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Category icon :",
                    style: TextStyle(
                        fontSize: 16, color: ColorApp.primaryTextColor),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      homeProvider.pickIcon(context);
                    },
                    child: Consumer<HomeProvider>(
                      builder: (context, value, child) => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ColorApp.boxColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: homeProvider.icon != null
                            ? Icon(
                                homeProvider.icon,
                                color: ColorApp.primaryTextColor,
                              )
                            : const Text(
                                "Choose icon from library",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorApp.primaryTextColor),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Category color :",
                    style: TextStyle(
                        fontSize: 16, color: ColorApp.primaryTextColor),
                  ),
                  const SizedBox(height: 16),

                  // ColorPick
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<HomeProvider>(
                        builder: (context, _, __) => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: basicColors.length,
                          itemBuilder: (context, index) {
                            final colors = basicColors[index];
                            final isSelected =
                                colors == homeProvider.selectedColors;

                            print(isSelected);

                            return GestureDetector(
                              onTap: () {
                                homeProvider.selectColors(colors);
                                Color materialColor = colors;
                                int colorValue = materialColor.value;
                                String colorHex =
                                    colorValue.toRadixString(16).toUpperCase();
                                homeProvider.getColor(colorHex);
                                print(homeProvider.colorCategory);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: isSelected
                                      ? ColorApp.secondColor.withOpacity(0.5)
                                      : null,
                                ),
                                margin: const EdgeInsets.only(right: 12),
                                child: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: basicColors[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 46),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 19),
                    ),
                    onPressed: () {
                      if (homeProvider.iconCategory != null &&
                          homeProvider.colorCategory != null) {
                        homeProvider.insert(
                          homeProvider.categoryController.text,
                          homeProvider.iconCategory ?? "f447",
                          homeProvider.colorCategory ?? "FF4CAF50",
                        );
                        homeProvider.addCategoryClear();
                        Navigator.of(context).pop();
                      } else {
                        // Salah satu atau lebih dari tiga nilai tersebut kosong (null).
                        // Tampilkan peringatan menggunakan showDialog.
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Peringatan"),
                              content: const Text(
                                  "Harap isi semua field sebelum melanjutkan."),
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
                      }
                    },
                    child: const Text(
                      "Create Category",
                      style: TextStyle(
                          fontSize: 16, color: ColorApp.primaryTextColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
