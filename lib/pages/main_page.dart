import 'package:flutter/material.dart';
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
      // const ShiftPage(),
      // const ActivityPage(),
      // const NotifPage(),
      // const ProfilPage()
    ];
    
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: widgetOptions.length,
        itemBuilder: (context, index) => widgetOptions.elementAt(index),
        onPageChanged: (index) {
          
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          menuNavBar(Icons.home_filled, "Home"),
          menuNavBar(Icons.home_filled, "Home"),
          menuNavBar(Icons.home_filled, "Home"),
          menuNavBar(Icons.home_filled, "Home"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {
            currentIndex;
          });
        },
      ),
    );
  }
}

menuNavBar(IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
