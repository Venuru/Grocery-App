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
} 