import 'package:demo_app/model/user.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/screens/register_screen.dart';
import 'package:demo_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId?>(context);

    // 1. If user is logged in, ALWAYS show Home
    if (user != null) {
      return const HomeScreen();
    } else {
      // 2. If NOT logged in, toggle between Sign In and Register
      return showSignIn 
        ? SigninScreen(toggleView: toggleView) 
        : RegisterScreen(toggleView: toggleView);
    }
  }
}