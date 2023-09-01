import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';

class FocusedPage extends StatefulWidget {
  const FocusedPage({super.key});

  @override
  State<FocusedPage> createState() => _FocusedPageState();
}

class _FocusedPageState extends State<FocusedPage> {
  final CountDownController countController = CountDownController();
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
  bool isStart = false;

  @override
  Widget build(BuildContext context) {
    int duration = (time.hour * 60 + time.minute) * 60;

    Future<void> selectTime(BuildContext context) async {
      TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: time,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      // if (pickedTime != null && pickedTime != selectedTime) {
      // pickedTime = selectedTime;

      setState(
        () {
          time = pickedTime!;
        },
      );
    }

    print("Mula : $isStart");

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
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await selectTime(context);
                  },
                  child: CircularCountDownTimer(
                    height: 200,
                    width: 200,
                    controller: countController,
                    duration: duration,
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
                      print('Countdown Started');
                    },
                    onChange: (String timeStamp) {
                      // Here, do whatever you want
                      print('Countdown Changed $timeStamp');
                    },
                    onComplete: () {
                      setState(
                        () {
                          isStart = false;
                          countController.restart(duration: duration);
                          countController.pause();
                          // isStart;
                          // countController;
                          print("Countdown Complete");
                        },
                      );
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
              const SizedBox(height: 20),
              const Text(
                "While your focus mode is on, all of your notifications will be off",
                style:
                    TextStyle(fontSize: 16, color: ColorApp.primaryTextColor),
                textAlign: TextAlign.center,
              ),
              Container(
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
                  onPressed: () {
                    if (duration == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Waktu tidak boleh kosong'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      setState(
                        () {
                          if (isStart == false) {
                            isStart = true;
                            countController.start();
                          } else if (isStart == true) {
                            isStart = false;
                            countController.restart(duration: duration);
                            countController.pause();
                          }

                          print("isState");
                        },
                      );
                    }

                    print("isStart : $isStart");
                    print("countStart: ${countController.isStarted}");
                  },
                  child: Text(
                    isStart == false ? "Start Focusing" : "Stop Focusing",
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorApp.primaryTextColor,
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
