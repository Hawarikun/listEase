import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_usage/app_usage.dart';

class AppUsageBarChart extends StatefulWidget {
  final String appName;

  const AppUsageBarChart({super.key, required this.appName});

  @override
  _AppUsageBarChartState createState() => _AppUsageBarChartState();
}

class _AppUsageBarChartState extends State<AppUsageBarChart> {
  List<double> appUsagePerDay = List.filled(7, 0);

  @override
  void initState() {
    super.initState();
    loadAppUsageData();
  }

  Future<void> loadAppUsageData() async {
    final DateTime now = DateTime.now();
    final DateTime lastWeek = now.subtract(const Duration(days: 7));

    final List<AppUsageInfo> usageInfoList = await AppUsage().getAppUsage(
      lastWeek,
      now,
    );

    for (final info in usageInfoList) {
      if (info.appName == widget.appName) {
        final int dayOfWeek =
            (info.endDate.weekday + 5) % 7; // Adjust to start from Monday
        final double usageInSeconds = info.usage.inSeconds.toDouble();

        appUsagePerDay[dayOfWeek] += usageInSeconds;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'App Usage Per Day for ${widget.appName} (Last Week)',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            height: 300,
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: true),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Mon';
                        case 1:
                          return 'Tue';
                        case 2:
                          return 'Wed';
                        case 3:
                          return 'Thu';
                        case 4:
                          return 'Fri';
                        case 5:
                          return 'Sat';
                        case 6:
                          return 'Sun';
                        default:
                          return '';
                      }
                    },
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[0],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[1],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[2],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[3],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[4],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[5],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        y: appUsagePerDay[6],
                        colors: [Colors.blue],
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
