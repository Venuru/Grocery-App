import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/app_logo.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/auth_providers.dart';
import 'package:grocery_app/screens/auth/signup.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:provider/provider.dart';

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
        // Helpers.navigateTo(context, Signup());
        Provider.of<AuthProviders>(context, listen: false).initializeUser(context);
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
              child: const AppLogo(width: 331.0, height: 225.0,)
            ),
            const SizedBox(height: 72),
            FadeInUp(
              child: const CustomText(
                'Shop Your Daily\nNecessary',
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

