import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/screens/auth/signup.dart';
import 'package:grocery_app/screens/main/main_screen.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:logger/logger.dart';

class AuthProviders extends ChangeNotifier {

  // auth controller object
  final AuthController _authController = AuthController();

  // userName textField controller
  final TextEditingController _userName = TextEditingController();

  TextEditingController get name => _userName;

  // email textField controller
  final TextEditingController _email = TextEditingController();

  TextEditingController get email => _email;

  // passwrod textField controller
  final TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  // validate text input
 bool validateFields(BuildContext context) {
    // first checking if all the textfileds are empty or not
    if (_userName.text.isEmpty || _email.text.isEmpty || _password.text.isEmpty) {
      Logger().w("Please fill all the fields");
      AlertHelper.showAlert(context, "Validation Error", "Please fill all the fields");
      return false;
    }else if (!_email.text.contains("@")) {
      Logger().w("Please enter a valid email");
      AlertHelper.showAlert(context, "Validation Error", "Please enter a valid email");
      return false;
    }else if (_password.text.length < 6) {
      Logger().w("The passwrod must have more than 6 digits");
      AlertHelper.showAlert(context, "Validation Error", "The passwrod must have more than 6 digits");
      return false;
    }else {
      Logger().w("All fields are validated");
      return true;
    }
  }

  //------ Loader state

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----- set Loader state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // start the signup process
  Future<void> startSingup(BuildContext context) async {
    try {
      // validating inputs
      if (validateFields(context)) {
        // start the loader
        setLoading(true);
        //start creating the user
        await _authController.signupUser(context, _email.text, _password.text);
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
      AlertHelper.showAlert(context, "SignUp error", "Server error");
    }
  }

  // ------ initialize the user and listen to the auth state

  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
        Logger().w("User is currently signed out!");
        // if the user is null, sent to the signUp
        Helpers.navigateTo(context, const Signup());
      } else {
        // is the user is not null, sent to the home
        Logger().w("User is signed in!");
        Helpers.navigateTo(context, const MainScreen());
      }
    });
  }

  // ------ signout function
  Future<void> logOut () async {
    await FirebaseAuth.instance.signOut();
  }
}