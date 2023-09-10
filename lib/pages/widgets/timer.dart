import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/focused_page/focused_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:provider/provider.dart';

class FocusModeTimerWidget extends StatelessWidget {
  const FocusModeTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final focusedProvider =
        Provider.of<FocusedProvider>(context, listen: false);

    return CircularCountDownTimer(
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
        focusedProvider
            .setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
        print('Countdown Started');
        print(focusedProvider.duration);
      },
      onChange: (String timeStamp) {
        // Here, do whatever you want
        print('Countdown Changed $timeStamp');
      },
      onComplete: () {
        focusedProvider
            .setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
        focusedProvider.changeIsStart(false);
        // focusedProvider.countDownController.reset();

        // focusedProvider.clear();
        print("Countdown Complete");
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "Start";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
