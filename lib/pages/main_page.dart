import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/calendar_page.dart';
import 'package:list_ease/pages/focused_page.dart';
import 'package:list_ease/pages/home_page.dart';

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
      const SizedBox()
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: widgetOptions.length,
        itemBuilder: (context, index) => widgetOptions.elementAt(index),
        onPageChanged: (index) {
          // if (index == 1 && pageController.page == 3) {
          //   // Pindahkan langsung dari indeks 1 ke indeks 3
          //   pageController.jumpToPage(3);
          //   currentIndex = 3;
          // } else if (index == 3 && pageController.page == 1) {
          //   // Pindahkan langsung dari indeks 3 ke indeks 1
          //   pageController.jumpToPage(1);
          //   currentIndex = 1;
          // }

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
          menuNavBar(
              currentIndex, 0, Ionicons.home, Ionicons.home_outline, "Home"),
          menuNavBar(currentIndex, 1, Ionicons.calendar,
              Ionicons.calendar_outline, "Calendar"),
          const BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          menuNavBar(
              currentIndex, 2, Ionicons.time, Ionicons.time_outline, "Focused"),
          menuNavBar(currentIndex, 3, Ionicons.person, Ionicons.person_outline,
              "Profil"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 3) {
            currentIndex = 2;
          } else {
            currentIndex = index;
          }
          pageController.jumpToPage(currentIndex);

          setState(() {
            currentIndex;
            pageController;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const Icon(Ionicons.add)),
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
