import 'package:demo_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return  SigninScreen();
  }
}