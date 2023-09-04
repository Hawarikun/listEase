import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/services/database/database.dart';

class HomeProvider extends ChangeNotifier {
  final database = AppDb();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  DateTime? _datePicked;
  String? _timePicked;
  String? _colorCategory;
  String? _iconCategory;

  IconData? _iconData;
  Color? _selectedColors;

  // IconData? _icon;

  DateTime? _currentDate;
  TimeOfDay? _currentTime;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;

  DateTime? get datePicked => _datePicked;
  String? get timePicked => _timePicked;
  String? get colorCategory => _colorCategory;
  String? get iconCategory => _iconCategory;

  IconData? get icon => _iconData;
  DateTime? get currentDate => _currentDate;
  TimeOfDay? get currentTime => _currentTime;
  Color? get selectedColors => _selectedColors;

  Category? selectedCategory;

  set setDatePicked(DateTime value) {
    _datePicked = value;
  }

  set setSelectedColor(Color? color) {
    _selectedColors = color;
  }

  set setTimePicked(DateTime value) {
    _datePicked = value;
  }

  set setIcon(IconData? icon) {
    _iconData = icon;
    // notifyListeners();
  }

  void getColor(String color) {
    _colorCategory = color;
    notifyListeners();
  }

  void selectCategory(Category? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void selectColors(Color? colors) {
    _selectedColors = colors;

    notifyListeners();
  }

  void pickIcon(BuildContext context) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _iconData = icon;

    IconData? iconData = icon;
    String unicodeValue = iconData!.codePoint.toRadixString(16);
    _iconCategory = unicodeValue;
    print("String : ${iconData.codePoint}");

    notifyListeners();

    debugPrint('Picked Icon:  $icon');
  }

  // String to Color and Icon
  void setData({String? iconUnicode, String? colorHex}) {
    final codePoint = int.parse("0$iconUnicode", radix: 16);
    _iconData = IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );

    final colorValue = int.parse("0x${colorHex!.toUpperCase()}");
    _selectedColors = Color(colorValue);

    selectColors(Color(colorValue));

    print(selectedColors);

    // notifyListeners();
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

      _datePicked = pickedDate;

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

    notifyListeners();

    print(_datePicked);
    print(_timePicked);
  }

  Future<List<Category>> getAllCategories() async {
    return await database.allCategories();
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

  Future update(
      int newId, String newName, String newIcon, String newColor) async {
    return await database.updateKategoriRepo(newId, newName, newIcon, newColor);
  }

  void updateIsComplete(int id, bool newCondition) async {
    await database.updateIsCompleteToDos(id, newCondition);

    notifyListeners();
  }

  Future insertToDos(int categoryId, String title, String description,
      DateTime date, String time) async {
    var now = DateTime.now();

    final row = await database.into(database.toDos).insertReturning(
          ToDosCompanion.insert(
            category_id: Value(categoryId),
            title: title,
            description: description,
            date: date,
            time: time,
            createdAt: now,
            updateedAt: now,
          ),
        );

    print(row);
  }

  void clear() {
    _titleController.clear();
    _descriptionController.clear();
    _currentDate = null;
    _currentTime = null;
    _datePicked = null;
    _timePicked = null;
    selectCategory(null);
  }

  void addCategoryClear() {
    _categoryController.clear();
    _colorCategory = null;
    _iconCategory = null;
    _iconData = null;
    _selectedColors = null;
    selectColors(null);
  }
}
