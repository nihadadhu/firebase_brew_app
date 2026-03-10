// import 'dart:async';
// import 'dart:ui';
// import 'package:demo_app/main.dart';
// import 'package:flutter/material.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController logoController;
//   late Animation<double> fadeAnimation;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     fadeAnimation = Tween<double>(begin: 0, end: 1).animate(logoController);
//     scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
//       CurvedAnimation(parent: logoController, curve: Curves.elasticOut),
//     );

//     logoController.forward();

//     Timer(const Duration(seconds: 3), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const Wrapper()),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     logoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff3E2723), Color(0xff5D4037), Color(0xff8D6E63)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: fadeAnimation,
//             child: ScaleTransition(
//               scale: scaleAnimation,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(25),
//                       border: Border.all(color: Colors.white.withOpacity(0.2)),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Icon(Icons.coffee, size: 80, color: Colors.white),
//                         SizedBox(height: 20),
//                         Text(
//                           "Brew Crew",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 3,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         CircularProgressIndicator(color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }