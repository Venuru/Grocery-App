import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertHelper {

  // shows a dilogbox
  static void showAlert(BuildContext context, String title, String desc, {DialogType dialogType = DialogType.error}) {
    AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.scale,
        title: title,
        desc: desc,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
    ).show();
  }

  // show a snack bar
  static void showSnackBar(BuildContext context, String msg, {AnimatedSnackBarType type = AnimatedSnackBarType.error}) {
    AnimatedSnackBar.material(
      msg,
      type: type,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
} 