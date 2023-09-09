import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/calendar_page/calendar_page.dart';
import 'package:list_ease/pages/focused_page/focused_page.dart';
import 'package:list_ease/pages/home/home_page.dart';
import 'package:list_ease/pages/main_page/main_provider.dart';
import 'package:list_ease/pages/profil_page/profil_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      const CalendarPage(),
      const FocusedPage(),
      const ProfilPage()
    ];

    return Scaffold(
      body: PageView.builder(
        controller: mainProvider.pageController,
        itemCount: widgetOptions.length,
        itemBuilder: (context, index) => widgetOptions.elementAt(index),
        onPageChanged: (index) {
          mainProvider.changeIndex(index);
        },
      ),
      bottomNavigationBar: Consumer<MainProvider>(
        builder: (context, _, __) => BottomNavigationBar(
          selectedFontSize: 12,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(color: ColorApp.boxColor),
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorApp.boxColor,
          selectedItemColor: ColorApp.primaryTextColor,
          unselectedItemColor: ColorApp.primaryTextColor,
          // useLegacyColorScheme: false,

          items: [
            if (mainProvider.currentIndex == 0 &&
                mainProvider.showBottomSheet == false) ...[
              menuNavBar(mainProvider.currentIndex, 0, Ionicons.home,
                  Ionicons.home_outline, "Home"),
              menuNavBar(mainProvider.currentIndex, 1, Ionicons.calendar,
                  Ionicons.calendar_outline, "Calendar"),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              menuNavBar(mainProvider.currentIndex, 2, Ionicons.time,
                  Ionicons.time_outline, "Focused"),
              menuNavBar(mainProvider.currentIndex, 3, Ionicons.person,
                  Ionicons.person_outline, "Profil"),
            ] else ...[
              menuNavBar(mainProvider.currentIndex, 0, Ionicons.home,
                  Ionicons.home_outline, "Home"),
              menuNavBar(mainProvider.currentIndex, 1, Ionicons.calendar,
                  Ionicons.calendar_outline, "Calendar"),
              menuNavBar(mainProvider.currentIndex, 2, Ionicons.time,
                  Ionicons.time_outline, "Focused"),
              menuNavBar(mainProvider.currentIndex, 3, Ionicons.person,
                  Ionicons.person_outline, "Profil"),
            ]
          ],
          currentIndex: mainProvider.currentIndex,
          onTap: (index) {
            if (mainProvider.currentIndex == 0 && index == 3) {
              mainProvider.changeIndex(2);
              print('object');
            } else {
              mainProvider.changeIndex(index);
            }
            print(mainProvider.currentIndex);
          },
        ),
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context, _, __) => Visibility(
          visible: (mainProvider.currentIndex == 0 &&
                  mainProvider.showBottomSheet == false)
              ? true
              : false,
          child: FloatingActionButton(
            onPressed: () {
              mainProvider.changeShowBottomSheet =
                  !mainProvider.showBottomSheet;
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: const Icon(Ionicons.add),
          ),
        ),
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
