import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MainProvider extends ChangeNotifier {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;
  int _currentIndex = 0;
  bool _showBottomSheet = false;

  int get currentIndex => _currentIndex;
  bool get showBottomSheet => _showBottomSheet;

  set changeShowBottomSheet(bool value) {
    _showBottomSheet = value;
    notifyListeners();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }

  Future<void> requestNotificationPolicyAccess(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Policy Access Permissions'),
          content: const Text(
              'The app requires notification policy access permissions to function properly. You can grant this permission in device settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
            TextButton(
              onPressed: () async {
                // Buka pengaturan perangkat untuk mengaktifkan izin
                final status =
                    await Permission.accessNotificationPolicy.request();
                Navigator.of(context).pop();

                if (status.isGranted) {
                  // Izin diberikan, Anda dapat mengaktifkan mode Jangan Ganggu.
                  print('Izin akses kebijakan notifikasi diberikan.');
                } else if (status.isPermanentlyDenied) {
                  // Pengguna menolak izin secara permanen, beri tahu mereka untuk pergi ke pengaturan perangkat.
                  print(
                      'Izin akses kebijakan notifikasi ditolak secara permanen. Buka pengaturan perangkat untuk mengaktifkannya.');
                } else {
                  // Pengguna menolak izin sementara atau belum memberikan izin.
                  print(
                      'Izin akses kebijakan notifikasi ditolak atau belum diberikan.');
                }
              },
              child: const Text('Buka Pengaturan'),
            ),
          ],
        );
      },
    );
  }
}
