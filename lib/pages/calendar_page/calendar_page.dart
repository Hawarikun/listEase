import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // AppBar(
          //   title: const Text(
          //     "Calendar",
          //     style: TextStyle(color: ColorApp.primaryTextColor),
          //   ),
          //   backgroundColor: ColorApp.boxColor,
          //   centerTitle: true,
          //   bottom:
          SafeArea(
        child: Column(
          children: [
            CalendarAgenda(
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
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now().add(const Duration(days: 140)),
              onDateSelected: (date) {
                selectedDate = date;
                setState(() {
                  selectedDate;
                });
              },
            ),
            Consumer<HomeProvider>(
              builder: (context, homeProvider, _) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    FutureBuilder<List<ToDosWithCategory>>(
                      future: homeProvider.database.allTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          ); // Tampilkan indikator loading jika data sedang dimuat.
                        } else if (snapshot.hasError) {
                          return Text("Error : ${snapshot.error}");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text(
                              'No data available'); // Tampilkan pesan jika tidak ada data.
                        } else {
                          return ListView.builder(
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
                                                color:
                                                    ColorApp.primaryTextColor,
                                              ),
                                            ),
                                            // const SizedBox(height: 6),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: color),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(icon, size: 14),
                                                      const SizedBox(width: 5),
                                                      Text(data.category
                                                          .categoryName)
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
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
