import 'package:demo_app/model/user.dart';
import 'package:demo_app/screens/signin_screen.dart';
import 'package:demo_app/screens/splash_screen.dart';
import 'package:demo_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final VoidCallback? toggleView;

  const MyApp({super.key, this.toggleView});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserId?>.value(
      //
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          toggleView: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SigninScreen(toggleView: toggleView ?? () {}),
              ),
            );
          },
        ),
      ),
    );
  }
}
