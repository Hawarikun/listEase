import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/services/database/database.dart';

class HomeProvider extends ChangeNotifier {
  final database = AppDb();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  DateTime? _selectedDate;
  DateTime? _datePicked;
  DateTime? _currentDate;

  TimeOfDay? _currentTime;

  String? _title;
  String? _description;
  String _dropdownValue = "Today";
  String? _timePicked;
  String? _colorCategory;
  String? _iconCategory;
  String? _formattedDate;

  bool _filter = true;
  bool? _isComplete;

  IconData? _iconData;
  Color? _selectedColors;

  // IconData? _icon;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;

  DateTime? get selectedDate => _selectedDate;
  DateTime? get datePicked => _datePicked;
  DateTime? get currentDate => _currentDate;

  TimeOfDay? get currentTime => _currentTime;

  String? get title => _title;
  String? get description => _description;
  String get dropdownValue => _dropdownValue;
  String? get timePicked => _timePicked;
  String? get colorCategory => _colorCategory;
  String? get iconCategory => _iconCategory;
  String? get formattedDate => _formattedDate;

  bool get filter => _filter;
  bool? get isComplate => _isComplete;

  IconData? get icon => _iconData;
  Color? get selectedColors => _selectedColors;

  Category? selectedCategory;

  set setFormattedDate(DateTime date) {
    _formattedDate = DateFormat("E, d MMM y").format(date);
  }
  
  set setCurrentDate(DateTime date) {
    _currentDate = date;
  }

  set setCurrentTime(TimeOfDay time) {
    _currentTime = time;
  }

  set setDatePicked(DateTime value) {
    _datePicked = value;
  }

  // set setTimePicked(DateTime value) {
  //   _datePicked = value;
  // }

  set setSelectedColor(Color? color) {
    _selectedColors = color;
  }

  set setTitle(String title) {
    _title = title;
  }

  set setDescription(String description) {
    _description = description;
  }


  set setDropdownValue(String newValue) {
    _dropdownValue = newValue;

    notifyListeners();
  }

  set setTimePicked(String time) {
    _timePicked = time;
  }

  set setFilter(bool value) {
    _filter = value;

    notifyListeners();
  }

  set setIsComplete(bool value) {
    _isComplete = value;
  }

  set setIcon(IconData? icon) {
    _iconData = icon;
    // notifyListeners();
  }

  void updateTitleDescription(String title, String description) {
    _title = title;
    _description = description;

    notifyListeners();
  }

  set setSelectedCategory(Category? category) {
    selectedCategory = category;
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;

    notifyListeners();
  }

  void pickDate(DateTime date) {
    _datePicked = date;
    _currentDate = date;
    notifyListeners();
  }

  void pickTime(String time, TimeOfDay timeOfDay) {
    _timePicked = time;
    _currentTime = timeOfDay;

    notifyListeners();
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

  void changeIsComplete(bool value) {
    _isComplete = value;
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
      _formattedDate = DateFormat("E, d MMM y").format(pickedDate);

      pickDate(pickedDate);

      TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: currentTime ?? const TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        String formattedTime = DateFormat.Hm().format(
          DateTime(1, 1, 1, pickedTime.hour, pickedTime.minute),
        );

        pickTime(formattedTime, pickedTime);
      }
    }

    // notifyListeners();

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
    return await database.updateKategoriRepo(
      newId,
      newName,
      newIcon,
      newColor,
    );
  }

  Future updateTodosTitle(
      int newId,
      int newIdCategory,
      String newTitle,
      String newDescription,
      DateTime newDate,
      String newTime,
      bool newIsComplete) async {
    final row = await database.updateTodosRepo(
      newId,
      newIdCategory,
      newTitle,
      newDescription,
      newDate,
      newTime,
      newIsComplete,
    );

    print(row);
  }

  void updateIsComplete(ToDosWithCategory data, bool newCondition) async {
    await database.updateIsCompleteToDos(data.toDos.id, newCondition);

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
            isCompleted: const Value(true),
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
    _title = null;
    _description = null;
    _formattedDate = null;
    _isComplete = null;
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
