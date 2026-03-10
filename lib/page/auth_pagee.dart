import 'package:demo_app/screens/register_screen.dart';
import 'package:demo_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (showSignIn) {
      return SigninScreen(toggleView: toggleView);
    } else {
      return RegisterScreen(toggleView: toggleView);
    }
  }
}