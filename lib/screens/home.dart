import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Center(
            child: Text(
              "BREW CREW",
              style: TextStyle(
                color: Colors.brown[100],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.brown[900],
          actions: [
            PopupMenuButton(
              color: Colors.brown[100],
              icon: Icon(Icons.more_vert, color: Colors.brown[100]),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'profile',
                  child: TextButton(
                    onPressed: () {
                      // Profile functionality would go here
                    },
                    child: Text(
                      "Profile",
                      style: TextStyle(color: Colors.brown[900]),
                    ),
                  ),
                ),

                PopupMenuItem(
                  value: 'logout',
                  child: TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.brown[900]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(),
      ),
    );
  }
}
