import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/focused_page/focused_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class FocusModeControlWidget extends StatelessWidget {
  const FocusModeControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final focusedProvider =
        Provider.of<FocusedProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 50,
      width: 175,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () async {
          if (focusedProvider.duration == 0 ||
              focusedProvider.duration == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Time cannot be empty'),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            final notificationPolicyStatus =
                await Permission.accessNotificationPolicy.status;

            if (notificationPolicyStatus.isGranted) {
              if (focusedProvider.isStart == false) {
                focusedProvider.changeIsStart(true);

                // focusedProvider.countDownController.reset();
                focusedProvider.countDownController
                    .restart(duration: focusedProvider.duration);
                focusedProvider.countDownController.start();
              } else {
                focusedProvider.changeIsStart(false);
                focusedProvider.countDownController
                    .restart(duration: focusedProvider.duration);
                focusedProvider.countDownController.reset();
                // focusedProvider.countDownController.pause();
                // focusedProvider.clear();
              }
            } else {
              mainProvider.requestNotificationPolicyAccess(context);
            }
          }

          print("isStart : ${focusedProvider.isStart}");
          print("countStart: ${focusedProvider.countDownController.isStarted}");
        },
        child: Text(
          focusedProvider.isStart == false ? "Start Focusing" : "Stop Focusing",
          style: const TextStyle(
            fontSize: 16,
            color: ColorApp.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
