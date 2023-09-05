import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/widgets/edit_todos.dart';
import 'package:provider/provider.dart';

class ListToDos extends StatelessWidget {
  final ToDosWithCategory data;
  final String formatted;
  final DateTime currentDate;
  final Color color;
  final IconData icon;

  const ListToDos({
    super.key,
    required this.data,
    required this.formatted,
    required this.currentDate,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorApp.boxColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Checkbox(
              value: !data.toDos.isCompleted,
              onChanged: (value) {
                homeProvider.updateIsComplete(
                    data.toDos.id, !data.toDos.isCompleted);
                print(data.toDos.isCompleted);
              },
              activeColor: ColorApp.secondColor,
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditToDos(data: data),
                  ),
                );
              },
              child: Container(
                color: ColorApp.boxColor,
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.toDos.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorApp.primaryTextColor,
                      ),
                    ),
                    data.toDos.isCompleted == false
                        ? const SizedBox(height: 12)
                        : const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.toDos.date == currentDate
                              ? "Today At ${data.toDos.time}"
                              : "$formatted At ${data.toDos.time}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorApp.borderColor,
                          ),
                        ),
                        data.toDos.isCompleted == true
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: color.withAlpha(100),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 14,
                                      color: color,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      data.category.categoryName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: ColorApp.primaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    data.toDos.isCompleted == false
                        ? const SizedBox(height: 8)
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
