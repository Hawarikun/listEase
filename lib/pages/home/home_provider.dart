import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/services/database/database.dart';

class HomeProvider extends ChangeNotifier {
  final database = AppDb();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  String _datePicked = "";
  String _timePicked = "";
  String? _colorCategory;
  String? _iconCategory;

  IconData? _icon;

  DateTime? _currentDate;
  TimeOfDay? _currentTime;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;

  // String get datePicked => _datePicked;
  // String get timePicked => _timePicked;
  String? get colorCategory => _colorCategory;
  String? get iconCategory => _iconCategory;

  IconData? get icon => _icon;
  DateTime? get currentDate => _currentDate;
  TimeOfDay? get currentTime => _currentTime;
  Category? selectedCategory;
  Color? selectedColors;

  set datePicked(String value) {
    _datePicked = value;
  }

  void getColor(String color) {
    _colorCategory = color;
    notifyListeners();
  }

  set timePicked(String value) {
    _datePicked = value;
  }

  set setIcon(IconData? icon) {
    _icon = icon;
    notifyListeners();
  }

  void selectCategory(Category? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void selectColors(
    Color? colors,
  ) {
    selectedColors = colors;

    notifyListeners();
  }

  void pickIcon(BuildContext context) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = icon;

    IconData? iconData = icon;
    String unicodeValue = iconData!.codePoint.toRadixString(16);
    _iconCategory = unicodeValue;
    print("String : ${iconData.codePoint}");

    notifyListeners();

    debugPrint('Picked Icon:  $icon');
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

    print(_datePicked);
    print(_timePicked);
  }

  Future insert(String name, String icon, String color) async {
    var now = DateTime.now();

    final row = await database.into(database.categories).insertReturning(
          CategoriesCompanion.insert(
              categoryName: name,
              color: color,
              icon: icon,
              createdAt: now,
              updateedAt: now),
        );

    print(row);
  }

  Future<List<Category>> getAllCategories() async {
    return await database.allCategories();
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

  void addCategoryClear() {
    _categoryController.clear();
    _colorCategory = null;
    _iconCategory = null;
    _icon = null;
    selectColors(null);
  }
}
