import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/widgets/add_categories.dart';
import 'package:list_ease/pages/widgets/container_category.dart';
import 'package:provider/provider.dart';

void showCategoryDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorApp.boxColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Choose Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.primaryTextColor),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddCategories(
                      category: null,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Ionicons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        content: Consumer<HomeProvider>(
          builder: (context, homeProvider, _) => FutureBuilder(
            future: homeProvider.getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                ); // Tampilkan indikator loading jika data sedang dimuat.
              } else if (snapshot.hasError) {
                return Text("Error : ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text(
                    'No data available'); // Tampilkan pesan jika tidak ada data.
              } else {
                return CustomScrollView(
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
                        childCount: snapshot.data!.length,
                        (BuildContext context, int index) {
                          final isSelected = snapshot.data![index] ==
                              homeProvider.selectedCategory;

                          return GestureDetector(
                            onTap: () {
                              homeProvider
                                  .selectCategory(snapshot.data![index]);
                              print(homeProvider.selectedCategory);
                            },
                            onLongPress: () {
                              print(snapshot.data![index]);
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  if (snapshot.data != null) {
                                    return AddCategories(
                                      category: snapshot.data![index],
                                    );
                                  } else {
                                    // Tampilkan pesan atau widget placeholder jika snapshot.data adalah null
                                    return const CircularProgressIndicator(); // Contoh placeholder
                                  }
                                }),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorApp.secondColor.withOpacity(0.3)
                                    : null,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: containerCategory(snapshot.data![index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
        actions: <Widget>[
          Consumer<HomeProvider>(
            builder: (context, value, child) => TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: ColorApp.secondColor),
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
