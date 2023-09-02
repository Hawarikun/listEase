import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/calendar_page.dart';
import 'package:list_ease/pages/focused_page.dart';
import 'package:list_ease/pages/home_page.dart';
import 'package:list_ease/pages/profil_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      const CalendarPage(),
      // const SizedBox(),
      const FocusedPage(),
      const ProfilPage()
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: widgetOptions.length,
        itemBuilder: (context, index) => widgetOptions.elementAt(index),
        onPageChanged: (index) {
          currentIndex = index;

          setState(() {
            currentIndex;
            pageController;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: ColorApp.boxColor),
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorApp.boxColor,
        selectedItemColor: ColorApp.primaryTextColor,
        unselectedItemColor: ColorApp.primaryTextColor,
        // useLegacyColorScheme: false,

        items: [
          if (currentIndex == 0) ...[
            menuNavBar(
                currentIndex, 0, Ionicons.home, Ionicons.home_outline, "Home"),
            menuNavBar(currentIndex, 1, Ionicons.calendar,
                Ionicons.calendar_outline, "Calendar"),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            menuNavBar(currentIndex, 2, Ionicons.time, Ionicons.time_outline,
                "Focused"),
            menuNavBar(currentIndex, 3, Ionicons.person,
                Ionicons.person_outline, "Profil"),
          ] else ...[
            menuNavBar(
                currentIndex, 0, Ionicons.home, Ionicons.home_outline, "Home"),
            menuNavBar(currentIndex, 1, Ionicons.calendar,
                Ionicons.calendar_outline, "Calendar"),
            menuNavBar(currentIndex, 2, Ionicons.time, Ionicons.time_outline,
                "Focused"),
            menuNavBar(currentIndex, 3, Ionicons.person,
                Ionicons.person_outline, "Profil"),
          ]
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          pageController.jumpToPage(currentIndex);

          setState(() {
            currentIndex;
            pageController;
          });
        },
      ),
      floatingActionButton: Visibility(
        visible: currentIndex == 0 ? true : false,
        child: FloatingActionButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: const Icon(Ionicons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

menuNavBar(
  int currentIndex,
  int index,
  IconData selectedIcon,
  IconData unSelectedIcon,
  String? label,
) {
  return BottomNavigationBarItem(
    icon: currentIndex == index ? Icon(selectedIcon) : Icon(unSelectedIcon),
    label: label,
  );
}
