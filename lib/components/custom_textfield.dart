import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.isObsecure = false,
    this.controller,
  });

  final String hintText;
  final String labelText;
  final bool isObsecure;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: AppColors.ash.withOpacity(0.3),
            offset: const Offset(0, 0),
            blurRadius: 10,
          )
        ]
      ),
      child: TextField(
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(
          hintText: 
            hintText,
            hintStyle: const TextStyle(
              color: AppColors.ash,
            ),
          label: CustomText(
            labelText,
            color: AppColors.ash,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(4.0),
          )
        ),
      ),
    );
  }
}