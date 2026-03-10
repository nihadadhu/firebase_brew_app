import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/provider/task_provder.dart';
import 'services/auth_service.dart';
import 'model/user.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        StreamProvider<UserId?>.value(
          value: AuthService().user,
          initialData: null,
        ),

        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}