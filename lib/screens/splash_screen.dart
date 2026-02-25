import 'dart:ui';
import 'package:demo_app/screens/signin_screen.dart';
import 'package:demo_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key, required this.toggleView});
  final Function toggleView;
  @override
  _SplashScreenState createState() => _SplashScreenState(); 
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    controller.forward();

    navigateUser();
  }

  navigateUser() async {
    await Future.delayed(Duration(seconds: 6));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Wrapper()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SigninScreen(toggleView: widget.toggleView)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3E2723), Color(0xff5D4037), Color(0xff8D6E63)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: FadeTransition(
            opacity: fadeAnimation,

            child: ScaleTransition(
              scale: scaleAnimation,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),

                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

                  child: Container(   
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),

                      borderRadius: BorderRadius.circular(25),

                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Hero(
                          tag: "coffee",

                          child: Icon(
                            Icons.coffee,

                            size: 60,

                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          "Brew Crew",

                          style: TextStyle(
                            fontSize: 32,

                            fontWeight: FontWeight.bold,

                            color: Colors.white,

                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
