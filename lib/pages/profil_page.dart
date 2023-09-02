import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:list_ease/constant/colors.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Profil",
                  style:
                      TextStyle(fontSize: 20, color: ColorApp.primaryTextColor),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: CircleAvatar(
                  maxRadius: 50,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Martha Hays",
                  style:
                      TextStyle(fontSize: 20, color: ColorApp.primaryTextColor),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  containerTask("10 Task left"),
                  containerTask("5 Task done")
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                "Settings",
                style:
                    TextStyle(fontSize: 14, color: ColorApp.primaryTextColor),
              ),
              const SizedBox(height: 4),
              listMenu(Ionicons.settings_outline, "App Settings"),
              const SizedBox(height: 16),
              const Text(
                "My Profil",
                style:
                    TextStyle(fontSize: 14, color: ColorApp.primaryTextColor),
              ),
              const SizedBox(height: 4),
              listMenu(Ionicons.person_outline, "Change name"),
              const SizedBox(height: 8),
              listMenu(Ionicons.camera_outline, "Change Image"),
              const SizedBox(height: 16),
              const Text(
                "listEase",
                style:
                    TextStyle(fontSize: 14, color: ColorApp.primaryTextColor),
              ),
              const SizedBox(height: 4),
              listMenu(Ionicons.grid_outline, "About listEase"),
              const SizedBox(height: 8),
              listMenu(Ionicons.alert_circle_outline, "FAQ"),
              const SizedBox(height: 8),
              listMenu(Ionicons.flash_outline, "Help & Feedback"),
              const SizedBox(height: 8),
              listMenu(Icons.thumb_up_alt_outlined, "Support Us")
            ],
          ),
        ),
      ),
    );
  }
}

Widget containerTask(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
    decoration: BoxDecoration(
        color: ColorApp.boxColor, borderRadius: BorderRadius.circular(4)),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, color: ColorApp.primaryTextColor),
    ),
  );
}

Widget listMenu(IconData icon, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorApp.primaryTextColor,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16, color: ColorApp.primaryTextColor),
            )
          ],
        ),
      ),
      const Icon(
        Ionicons.chevron_forward,
        color: ColorApp.primaryTextColor,
      )
    ],
  );
}
