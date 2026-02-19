import 'package:demo_app/model/user.dart';
import 'package:demo_app/screens/auth_screen.dart';
import 'package:demo_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId?>(context);
    print(user);
    if (user == null) {
      return Authentication();
    } else {
      return HomeScreen();
    }
  }
}
