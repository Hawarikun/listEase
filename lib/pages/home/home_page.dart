import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:list_ease/pages/widgets/custom_buttom_sheet.dart';
import 'package:list_ease/pages/widgets/dropdown.dart';
import 'package:list_ease/pages/widgets/empty_data.dart';
import 'package:list_ease/pages/widgets/list_todos.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    DateTime now = DateTime.now();
    int day = now.day;
    int month = now.month;
    int year = now.year;
    DateTime currentDate = DateTime(year, month, day);

    print(homeProvider.database);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search for your task...",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: ColorApp.borderColor,
                  ),
                  prefixIcon: Icon(
                    Ionicons.search,
                    color: ColorApp.borderColor,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const CustomDropdownButton(),
              const SizedBox(height: 16),
              Consumer<HomeProvider>(
                builder: (context, homeProvider, _) => SingleChildScrollView(
                  child: StreamBuilder<List<ToDosWithCategory>>(
                    stream: homeProvider.database
                        .getToDosByDateRepo(currentDate, homeProvider.filter),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final formatted = DateFormat("E, d MMM y")
                                    .format(snapshot.data![index].toDos.date);
                                final data = snapshot.data![index];

                                // string to color
                                final colorString = data.category.color;
                                Color color =
                                    Color(int.parse("0x$colorString"));

                                // string to icon
                                String unicodeValue =
                                    data.category.icon.toUpperCase();
                                int codePoint =
                                    int.parse("0$unicodeValue", radix: 16);
                                IconData icon = IconData(
                                  codePoint,
                                  fontFamily: 'MaterialIcons',
                                );
                                return ListToDos(
                                  data: data,
                                  formatted: formatted,
                                  currentDate: currentDate,
                                  color: color,
                                  icon: icon,
                                );
                              },
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(child: EmptyData()),
                            );
                          }
                        } else {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(child: EmptyData()),
                          );
                        }
                      }
                    },
                  ),
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
