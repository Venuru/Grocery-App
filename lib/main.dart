import 'package:flutter/material.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/main/cart/cart.dart';
import 'package:grocery_app/screens/main/home/home.dart';
import 'package:grocery_app/screens/main/main_screen.dart';
import 'package:grocery_app/screens/main/profile/profile.dart';
import 'package:grocery_app/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0FA956)),
        useMaterial3: true,
      ),
      home: const Cart(),
    );
  }
}
