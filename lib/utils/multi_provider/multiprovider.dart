import 'package:flutter/material.dart';
import 'package:list_ease/pages/calendar_page/calendar_provider.dart';
import 'package:list_ease/pages/home/home_provider.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:provider/provider.dart';

MultiProvider buildAppProvider(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MainProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HomeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CalendarProvider(),
      ),
    ],
    child: child,
  );
}
