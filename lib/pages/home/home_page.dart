import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:list_ease/pages/widgets/custom_buttom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    DateTime now = DateTime.now();
    int day = now.day; // Mengambil tanggal (hanya tanggal)
    int month = now.month; // Mengambil bulan
    int year = now.year;
    DateTime currentDate = DateTime(year, month, day);

    print(homeProvider.database);
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
              Consumer<HomeProvider>(
                builder: (context, homeProvider, _) =>
                    StreamBuilder<List<ToDosWithCategory>>(
                  stream: homeProvider.database.getToDosByDateRepo(currentDate),
                  builder: (context, snapshot) {
                    print(snapshot.data!.length);
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error : ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/Checklist.png"),
                            const Text(
                              "What do you want to do today?",
                              style:
                                  TextStyle(color: ColorApp.primaryTextColor),
                            ),
                            const Text(
                              "Tap + to add your tasks",
                              style:
                                  TextStyle(color: ColorApp.primaryTextColor),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final formatted = DateFormat("E, d MMM y")
                                .format(snapshot.data![index].toDos.date);
                            final data = snapshot.data![index];

                            DateTime now = DateTime.now();
                            int day =
                                now.day; // Mengambil tanggal (hanya tanggal)
                            int month = now.month; // Mengambil bulan
                            int year = now.year;
                            DateTime currentDate = DateTime(year, month, day);

                            // string to color
                            final colorString = data.category.color;
                            Color color = Color(int.parse("0x$colorString"));

                            // string to icon
                            String unicodeValue =
                                data.category.icon.toUpperCase();
                            int codePoint =
                                int.parse("0$unicodeValue", radix: 16);
                            IconData icon = IconData(
                              codePoint,
                              fontFamily: 'MaterialIcons',
                            );

                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: ColorApp.boxColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Checkbox(
                                      value: !snapshot
                                          .data![index].toDos.isCompleted,
                                      onChanged: (value) {
                                        homeProvider.updateIsComplete(
                                            data.toDos.id,
                                            !data.toDos.isCompleted);
                                        print(data.toDos.isCompleted);
                                      },
                                      activeColor: ColorApp.secondColor,
                                      shape: const CircleBorder(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, bottom: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.toDos.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: ColorApp.primaryTextColor,
                                            ),
                                          ),
                                          // const SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.toDos.date == currentDate
                                                    ? "Today At ${data.toDos.time}"
                                                    : "$formatted At ${data.toDos.time}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ColorApp.borderColor,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: color),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(icon, size: 14),
                                                    const SizedBox(width: 5),
                                                    Text(data
                                                        .category.categoryName)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
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
