import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/focused_page/focused_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:list_ease/pages/widgets/app_usage_statistic.dart';
import 'package:list_ease/pages/widgets/timer.dart';
import 'package:list_ease/pages/widgets/timer_control.dart';
import 'package:provider/provider.dart';

class FocusedPage extends StatelessWidget {
  const FocusedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FocusedProvider>(context, listen: false).loadInstalledApps();
    Provider.of<FocusedProvider>(context, listen: false).getAppUsageInfo();

    final focusedProvider =
        Provider.of<FocusedProvider>(context, listen: false);

    String getAppWithHighestUsage(Map<String, double> appUsage) {
      String appNameWithHighestUsage = '';
      double highestUsage = 0.0;

      appUsage.forEach((appName, usage) {
        if (usage > highestUsage) {
          highestUsage = usage;
          appNameWithHighestUsage = appName;
        }
      });

      return appNameWithHighestUsage;
    }

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

              // timer
              Consumer<FocusedProvider>(
                builder: (context, _, __) => Center(
                  child: GestureDetector(
                    onTap: () {
                      focusedProvider.selectTime(context);
                    },
                    child: const FocusModeTimerWidget(),
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

              // timer controller
              Consumer2<FocusedProvider, MainProvider>(
                builder: (context, _, mainProvider, __) =>
                    const FocusModeControlWidget(),
              ),

              // app usage
              const SizedBox(height: 40),
              const Row(
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                        fontSize: 20, color: ColorApp.primaryTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // AppUsageBarChart(
              //     appName: getAppWithHighestUsage(focusedProvider.appUsage)),
              AppUsageStatisticWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
