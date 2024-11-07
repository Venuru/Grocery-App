import 'package:flutter/material.dart';

class SizeConfig {

  // Get screen height
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Get screen width
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}