import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/models/category_model.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _datePicked = "";
  String _timePicked = "";

  DateTime? _currentDate;
  TimeOfDay? _currentTime;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  String get datePicked => _datePicked;
  String get timePicked => _timePicked;
  DateTime? get currentDate => _currentDate;
  TimeOfDay? get currentTime => _currentTime;
  CategoryModel? selectedCategory;

  set datePicked(String value) {
    _datePicked = value;
  }

  set timePicked(String value) {
    _datePicked = value;
  }

  void selectCategory(CategoryModel? category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _currentDate = pickedDate;

      String formattedDate = DateFormat('dd MMM y').format(pickedDate);

      _datePicked = formattedDate;

      TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: currentTime ?? const TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        _currentTime = pickedTime;
        String formattedTime = DateFormat.Hm().format(
          DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute),
        );

        _timePicked = formattedTime;
      }
    }

    print(datePicked);
    print(timePicked);
  }

  void clear() {
    _titleController.clear();
    _descriptionController.clear();
    _currentDate = null;
    _currentTime = null;
    _datePicked = "";
    _timePicked = "";
    selectCategory(null);
  }
}
