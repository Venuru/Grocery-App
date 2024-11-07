import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      }, 
      icon: const Icon(Icons.arrow_back_ios));
  }
}