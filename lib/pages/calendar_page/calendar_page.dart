import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';

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
        child: CalendarAgenda(
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
      ),
      // ),
    );
  }
}
