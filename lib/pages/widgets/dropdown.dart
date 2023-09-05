import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:provider/provider.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ColorApp.boxColor,
        ),
        child: DropdownButton<String>(
          isDense: true,
          dropdownColor: ColorApp.boxColor,
          underline: const SizedBox(),
          icon: const Icon(
            Ionicons.chevron_down_outline,
            color: ColorApp.primaryTextColor,
            size: 18,
          ),
          style:
              const TextStyle(fontSize: 12, color: ColorApp.primaryTextColor),
          value: homeProvider.dropdownValue,
          onChanged: (String? newValue) {
            homeProvider.setDropdownValue = newValue!;
            if (homeProvider.dropdownValue == 'Today') {
              homeProvider.setFilter = true;
              print(homeProvider.filter);
            } else if (homeProvider.dropdownValue == 'Completed') {
              homeProvider.setFilter = false;
              print(homeProvider.filter);
            }
          },
          items: <String>['Today', 'Completed'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                    padding: homeProvider.dropdownValue == 'Completed'
                        ? const EdgeInsets.only(right: 10)
                        : const EdgeInsets.all(0),
                    child: Text(value)),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
