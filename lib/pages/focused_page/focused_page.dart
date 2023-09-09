import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/focused_page/focused_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class FocusedPage extends StatelessWidget {
  const FocusedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final focusedProvider =
        Provider.of<FocusedProvider>(context, listen: false);

    print("state");

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Text(
                "Focus Mode",
                style:
                    TextStyle(fontSize: 20, color: ColorApp.primaryTextColor),
              ),
              const SizedBox(height: 50),
              Consumer<FocusedProvider>(
                builder: (context, _, __) => Center(
                  child: GestureDetector(
                    onTap: () {
                      focusedProvider.selectTime(context);
                    },
                    child: CircularCountDownTimer(
                      height: 200,
                      width: 200,
                      controller: focusedProvider.countDownController,
                      initialDuration: 0,
                      duration: focusedProvider.duration ?? 0,
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: ColorApp.primaryTextColor,
                      ),
                      fillColor: ColorApp.boxColor,
                      ringColor: ColorApp.secondColor,
                      isReverse: true,
                      isReverseAnimation: true,
                      autoStart: false,
                      textFormat: CountdownTextFormat.HH_MM_SS,
                      onStart: () {
                        focusedProvider.setInterruptionFilter(
                            FlutterDnd.INTERRUPTION_FILTER_NONE);
                        print('Countdown Started');
                        print(focusedProvider.duration);
                      },
                      onChange: (String timeStamp) {
                        // Here, do whatever you want
                        print('Countdown Changed $timeStamp');
                      },
                      onComplete: () {
                        focusedProvider.setInterruptionFilter(
                            FlutterDnd.INTERRUPTION_FILTER_ALL);
                        focusedProvider.changeIsStart(false);
                        // focusedProvider.countDownController.reset();

                        // focusedProvider.clear();
                        print("Countdown Complete");
                      },
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "Start";
                        } else {
                          return Function.apply(
                              defaultFormatterFunction, [duration]);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "While your focus mode is on, all of your notifications will be off",
                style:
                    TextStyle(fontSize: 16, color: ColorApp.primaryTextColor),
                textAlign: TextAlign.center,
              ),
              Consumer2<FocusedProvider, MainProvider>(
                builder: (context, _, mainProvider, __) => Container(
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
                      print(
                          "countStart: ${focusedProvider.countDownController.isStarted}");
                    },
                    child: Text(
                      focusedProvider.isStart == false
                          ? "Start Focusing"
                          : "Stop Focusing",
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorApp.primaryTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
