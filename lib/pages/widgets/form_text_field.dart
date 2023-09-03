import 'package:flutter/material.dart';
import 'package:list_ease/constant/colors.dart';

Widget formTextField(TextEditingController controller, String hintText) {
  return TextField(
    scrollPadding: const EdgeInsets.all(0),
    controller: controller,
    style: const TextStyle(fontSize: 18, color: ColorApp.borderColor),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 18, color: ColorApp.borderColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      isDense: true,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorApp.borderColor,
        ),
      ),
    ),
  );
}
