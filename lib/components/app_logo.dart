import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 202.0,
    this.height = 138.0,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.getImgName("logo.png"),
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}