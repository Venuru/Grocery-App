import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.btnColor = Colors.black,
  });

  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: btnColor,
      onPressed: () {
        Navigator.of(context).pop();
      }, 
      icon: const Icon(Icons.arrow_back_ios));
  }
}