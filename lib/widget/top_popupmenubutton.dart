import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class TopPopupmenubutton {
  Widget build(BuildContext context) {
       final auth = AuthService();
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        const PopupMenuItem(value: "profile", child: Text("Profile")),
        const PopupMenuItem(value: "settings", child: Text("Settings")),
        const PopupMenuItem(value: "logout", child: Text("Logout")),
      ],
      onSelected: (value) {
        if (value == "profile") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
          // );
        }

        if (value == "settings") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SettingsScreen()),
          // );
        }

        if (value == "logout") {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                  "Confirm Logout",
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
