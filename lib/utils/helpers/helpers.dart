import 'package:flutter/material.dart';

class Helpers {
  // Store all the helper methods here.
  
  // Push navigator function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}