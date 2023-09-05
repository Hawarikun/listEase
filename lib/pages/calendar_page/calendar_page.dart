import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/calendar_page/calendar_provider.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/widgets/empty_data.dart';
import 'package:list_ease/pages/widgets/list_todos.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer<HomeProvider>(
              builder: (context, homeProvider, _) => CalendarAgenda(
                calendarBackground: ColorApp.boxColor,
                // calendarEventSelectedColor: ColorApp.secondColor,
                // dateColor: ColorApp.secondColor,
                // selectedDateColor: ColorApp.secondColor,
                calendarEventColor: ColorApp.secondColor,
                selectedDateColor: ColorApp.secondColor,
                locale: "id",
                backgroundColor: ColorApp.boxColor,
                selectedDayPosition: SelectedDayPosition.center,
                // appbar: true,
                initialDate: homeProvider.selectedDate ?? DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 140)),
                lastDate: DateTime.now().add(const Duration(days: 140)),
                onDateSelected: (date) {
                  homeProvider.setSelectedDate(date);

                  print(date);
                  print(homeProvider.selectedDate);
                },
              ),
            ),
            Consumer<CalendarProvider>(
              builder: (context, calendarProvider, _) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorApp.boxColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterContainer(
                      calendarProvider.filter == true,
                      "Today",
                      onTap: () {
                        calendarProvider.setfilter = true;
                        print(calendarProvider.filter);
                      },
                    ),
                    filterContainer(
                      calendarProvider.filter == false,
                      "Completed",
                      onTap: () {
                        calendarProvider.setfilter = false;
                        print(calendarProvider.filter);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, homeProvider, _) {
                DateTime date = homeProvider.selectedDate ?? DateTime.now();
                int day = date.day;
                int month = date.month;
                int year = date.year;
                DateTime currentDate = DateTime(year, month, day);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Consumer<CalendarProvider>(
                    builder: (context, calendarProvider, _) =>
                        StreamBuilder<List<ToDosWithCategory>>(
                      stream: homeProvider.database.getToDosByDateRepo(
                          currentDate, calendarProvider.filter),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              return const EmptyData();
                            }
                          } else {
                            return const EmptyData();
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

Widget filterContainer(bool isFiltered, String text, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: isFiltered
            ? null
            : Border.all(width: 2, color: ColorApp.borderColor),
        color: isFiltered ? ColorApp.secondColor : null,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: ColorApp.primaryTextColor,
          ),
        ),
      ),
    ),
  );
}
