

import 'package:demo_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          onPressed: () async {
          User? result = await _auth.signinAnon();
            if (result == null) {
              print("error signing in");
            } else {
              print("signed in");
              print(result.uid);
            }
          },
          child: Text('Sign in anon',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
