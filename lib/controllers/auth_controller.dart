import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:logger/logger.dart';

class AuthController {

  //------signup a user function
  Future<void> signupUser(BuildContext context, emailAddress, String password, String name) async {
    try {
      // send the email and password to the firebase and try to create an user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((credential) => {
        if (credential.user != null) {
          Logger().w("User created successfully"),
          AlertHelper.showAlert(context, "Successfull Account", "User created successfully", dialogType: DialogType.success),
          // sucess save extra user data
          saveUserData(emailAddress, name, credential.user!.uid)
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

  // create a collection reference called users
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // ------- save extra user data in cloud firestore
  Future<void> saveUserData(String email, String name, String uid) async {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(uid)
        .set({
            'uid': uid,
            'name': name,
            'email': email,
            'img': AppAssets.profileUrl
          })
          .then((value) => Logger().i("User Added"))
          .catchError((error) => Logger().e("Failed to add user: $error"));
  }

    //------login user function
  Future<void> loginUser(BuildContext context, loginEmail, String loginPassword, ) async {
    try {
      // send the email and password to the firebase and try to sign an user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmail,
        password: loginPassword,
      ).then((credential) => {
        Logger().i(credential)
      });
    } on FirebaseAuthException catch (e) {
      AlertHelper.showAlert(context, e.code, e.code);
      if (e.code == 'user-not-found') {
        AlertHelper.showAlert(context, "User Not Found", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        AlertHelper.showAlert(context, "Password Error", "Wrong password provided for that user.");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

    //------send password reset email
  Future<void> sendEmail(BuildContext context, resetEmail,) async {
    try {
      // send the email and password to the firebase and try to sign an user
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: resetEmail,
      ).then((value) => {
        AlertHelper.showAlert(context, "Passwrod Rest Email", "Email sent!, check your inbox", dialogType: DialogType.success)
      });
    } on FirebaseAuthException catch (e) {
      AlertHelper.showAlert(context, 'Passwrod Rest Email', e.code);
    } catch (e) {
      Logger().e(e);
    }
  }

  //-------fetch userdata from cloudfirestore
  Future<UserModel?> fetchUserdata(BuildContext context, String uid) async {
    try {
      //-----firebase query that find and fetch user data acording to the uid
      DocumentSnapshot documentSnapshot = await users
        .doc(uid)
        .get();
        if(documentSnapshot.exists) {
          Logger().w(documentSnapshot.data());

          // mapping fetched data into a usermodel
          UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

          return userModel;
        }else {
          Logger().e("No data found");
          return null;
        }
    }catch(e) {
      Logger().e(e.toString());
      return null;
    }
  }
}