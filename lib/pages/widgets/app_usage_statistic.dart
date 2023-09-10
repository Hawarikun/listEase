import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/focused_page/focused_provider.dart';
import 'package:provider/provider.dart';

class AppUsageStatisticWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final focusedProvider =
        Provider.of<FocusedProvider>(context, listen: false);

    return FutureBuilder(
      future: focusedProvider.sortInstalledAppsByUsage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: min(focusedProvider.installedApps.length, 10),
            itemBuilder: (context, index) {
              final app = focusedProvider.installedApps[index];
              final appUsageSeconds =
                  focusedProvider.appUsage[app.packageName] ?? 0;
              final int appUsageMinutes =
                  appUsageSeconds ~/ 60; // Konversi ke menit
              final int appUsageHours = appUsageMinutes ~/ 60; // Jam
              final int remainingMinutes = appUsageMinutes % 60;
              final String formattedTime =
                  'You spent ${appUsageHours}h ${remainingMinutes}m on ${app.appName} today';

              print(focusedProvider.appUsage[app.packageName] ?? 0);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorApp.boxColor,
                ),
                child: ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(
                          app.icon,
                          width: 32,
                          height: 32,
                        )
                      : null,
                  title: Text(
                    app.appName,
                    style: const TextStyle(color: ColorApp.primaryTextColor),
                  ),
                  subtitle: Text(
                    formattedTime,
                    style: const TextStyle(
                        fontSize: 12, color: ColorApp.primaryTextColor),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
