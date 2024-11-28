import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnWidth = 259.0,
    this.isLoading = false,
  });

  final String text;
  final Function() onTap; 
  final double btnWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: btnWidth,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.ash.withOpacity(0.3),
              offset: const Offset(0, 0),
              blurRadius: 10,
            )
          ]
        ),
        child: isLoading
          ? const SpinKitThreeBounce(
            color: AppColors.white,
            size: 20.0,
          ) 
          : CustomText(
            text,
            fontSize: 18.0,
            color: Colors.white,
          ),
      ),
    );
  }
}