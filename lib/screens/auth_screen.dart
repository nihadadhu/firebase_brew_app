
import 'package:demo_app/screens/register_screen.dart';
import 'package:demo_app/screens/signin_screen.dart';

import 'package:flutter/material.dart';


class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Authentication> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return showSignIn ? SigninScreen(toggleView: toggleView) : RegisterScreen(toggleView: toggleView); // Show the appropriate screen based on the showSignIn flag.
  }
}
