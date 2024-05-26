import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/auth/signup.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    // delay  for 3 seconds and navigate to the signup screen
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
      }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: Image.asset(
                AppAssets.getImgName("logo.png"),
                width: 331,
                height: 225,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 72),
            FadeInUp(
              child: const Text(
                'Shop Your Daily\nNecessary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}