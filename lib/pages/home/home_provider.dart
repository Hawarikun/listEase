import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _datePicked = "";
  String _timePicked = "";

  final DateTime _currentDate = DateTime.now();
  final TimeOfDay _currentTime = const TimeOfDay(hour: 0, minute: 0);

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  String get datePicked => _datePicked;
  String get timePicked => _timePicked;
  DateTime get currentDate => _currentDate;
  TimeOfDay get currentTime => _currentTime;

  set datePicked(String value) {
    _datePicked = value;
  }

  set timePicked(String value) {
    _datePicked = value;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd MMM y').format(pickedDate);

      _datePicked = formattedDate;

      TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: currentTime,
      );

      if (pickedTime != null) {
        String formattedTime = DateFormat.Hm().format(
          DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute),
        );

        _timePicked = formattedTime;
      }
    }

    print(datePicked);
    print(timePicked);
  }
}
