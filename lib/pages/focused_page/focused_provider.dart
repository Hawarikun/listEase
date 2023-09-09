import 'package:app_usage/app_usage.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:usage_stats/usage_stats.dart';

class FocusedProvider extends ChangeNotifier {
  List<Application> _installedApps = [];
  Map<String, double> _appUsage = {};
  final CountDownController _countDownController = CountDownController();
  TimeOfDay? _time;
  bool _isStart = false;
  int? _duration;

  bool _isNotificationPolicyAccessGranted = false;
  String _filterName = '';

  List<Application> get installedApps => _installedApps;
  Map<String, double> get appUsage => _appUsage;
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

  Future<void> loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,
    );

    _installedApps = apps;

    notifyListeners();
  }

  Future<void> getAppUsageInfo() async {
    UsageStats.grantUsagePermission();

    try {
      final usageInfoList = await AppUsage().getAppUsage(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            0, 0, 0, 0),
        DateTime.now(),
      );

      final Map<String, double> appUsage = {};

      for (final info in usageInfoList) {
        if (appUsage.containsKey(info.packageName)) {
          appUsage[info.packageName] = (appUsage[info.packageName] ?? 0) +
              info.usage.inSeconds.toDouble();
        } else {
          appUsage[info.packageName] = info.usage.inSeconds.toDouble();
        }
      }

      _appUsage = appUsage;
    } on AppUsageException catch (exception) {
      print('Error: $exception');
    }
  }

  Future<void> sortInstalledAppsByUsage() async {
    await loadInstalledApps();
    await getAppUsageInfo();

    // Sort the installed apps by usage in descending order
    _installedApps.sort((app1, app2) {
      final double usage1 = _appUsage[app1.packageName] ?? 0;
      final double usage2 = _appUsage[app2.packageName] ?? 0;
      return usage2.compareTo(usage1);
    });

    notifyListeners();
  }

  // Future<void> getAppUsageInfo() async {
  //   UsageStats.grantUsagePermission();
  //   // if (isUsagePermissionGranted == true) {
  //   //   // Izin akses pengguna diberikan, lakukan tindakan yang sesuai.
  //   //   print('Izin akses pengguna diberikan.');
  //   try {
  //     DateTime endDate = DateTime.now();
  //     DateTime startDate = endDate.subtract(const Duration(days: 7));

  //     final infoList = await AppUsage().getAppUsage(startDate, endDate);

  //     infoList.sort((a, b) => b.usage.compareTo(a.usage));

  //     _appUsageInfoList = infoList;

  //     notifyListeners();
  //   } on AppUsageException catch (exception) {
  //     print('Error: $exception');
  //   }
  //   // } else {
  //   //   // Izin akses pengguna belum diberikan, mungkin perlu meminta izin.
  //   //   print('Izin akses pengguna belum diberikan.');
  //   // }
  // }
}
