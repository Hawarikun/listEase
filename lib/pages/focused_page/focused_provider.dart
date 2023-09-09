import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

class FocusedProvider extends ChangeNotifier {
  final CountDownController _countDownController = CountDownController();
  TimeOfDay? _time;
  bool _isStart = false;
  int? _duration;

  bool _isNotificationPolicyAccessGranted = false;
  String _filterName = '';

  CountDownController get countDownController => _countDownController;
  TimeOfDay? get time => _time;
  bool get isStart => _isStart;
  int? get duration => _duration;

  bool get isNotificationPolicyAccessGranted =>
      _isNotificationPolicyAccessGranted;
  String get filterName => _filterName;

  void changeIsStart(bool value) {
    _isStart = value;

    notifyListeners();
  }

  set setDuration(int value) {
    _duration = value;
    notifyListeners();
  }

  Future<void> updateDNDState() async {
    int? filter = await FlutterDnd.getCurrentInterruptionFilter();
    if (filter != null) {
      String filterName = FlutterDnd.getFilterName(filter);
      bool? isNotificationPolicyAccessGranted =
          await FlutterDnd.isNotificationPolicyAccessGranted;

      _isNotificationPolicyAccessGranted =
          isNotificationPolicyAccessGranted ?? false;
      _filterName = filterName;

      notifyListeners();
    }
  }

  Future<void> setInterruptionFilter(int filter) async {
    final bool? isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateDNDState();
    }
  }

  Future selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: time ?? const TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      _time = pickedTime;

      final formated = (pickedTime.hour * 60 + pickedTime.minute) * 60;

      setDuration = formated;
    }

    _countDownController.reset();

    notifyListeners();

    print(_duration);
    print(_time);
  }

  void clear() {
    _time = null;
    _duration = null;

    notifyListeners();
  }
}
