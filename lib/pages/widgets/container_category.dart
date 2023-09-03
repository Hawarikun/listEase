import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/services/database/database.dart';

Widget containerCategory(Category data) {
  String unicodeValue =
      data.icon.toUpperCase(); // Nilai Unicode dalam format heksadesimal

  int codePoint = int.parse("0$unicodeValue",
      radix: 16); // Mengonversi string heksadesimal menjadi integer

  IconData icon = IconData(
    codePoint,
    fontFamily: 'MaterialIcons',
  );

  final colorString = data.color;
  Color color = Color(int.parse("0x$colorString"));
  int alpha = 50;
  Color colorOpacyty = color.withAlpha(alpha);

  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: colorOpacyty,
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        data.categoryName,
        style: const TextStyle(color: ColorApp.primaryTextColor),
      )
    ],
  );
}
