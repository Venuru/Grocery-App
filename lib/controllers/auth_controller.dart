import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:logger/logger.dart';

class AuthController {

  //------signup a user function
  Future<void> signupUser(BuildContext context, emailAddress, String password) async {
    try {
      // send the email and password to the firebase and try to create an user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((credential) => {
        if (credential.user != null) {
          Logger().w("User created successfully"),
          AlertHelper.showAlert(context, "Successfull Account", "User created successfully", dialogType: DialogType.success),
        }else {
          Logger().w("Couldn't created successfully")
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AlertHelper.showAlert(context, "Validation Error", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        AlertHelper.showAlert(context, "Validation Error", "The account already exists for that email.");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}