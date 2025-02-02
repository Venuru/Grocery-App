import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/providers/home/product_provider.dart';
import 'package:grocery_app/screens/auth/signup.dart';
import 'package:grocery_app/screens/main/main_screen.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

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
        await _authController.signupUser(context, _email.text, _password.text, _userName.text).then(
          (value) => {
            // cleatr the controllers
            _email.clear(),
            _userName.clear(),
            _password.clear(),

            //stop the loader
            setLoading(false)
          });
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
    .listen((User? user) async {
      if (user == null) {
        Logger().w("User is currently signed out!");
        // if the user is null, sent to the signUp
        Helpers.navigateTo(context, const Signup());
      } else {
        await startFetchUserData(context, user.uid).then(
          (value) {
            
            Logger().w("User is signed in!");

            // start fetch product list
            Provider.of<ProductProvider>(context, listen: false).startFetchProductList();

            // is the user is not null, sent to the home
            Helpers.navigateTo(context, const MainScreen());
          }
        );
      }
    });
  }

  // ------ signout function
  Future<void> logOut () async {
    await FirebaseAuth.instance.signOut();
  }

  // ------ login user feature

  // email textField controller
  final TextEditingController _loginEmail = TextEditingController();

  TextEditingController get loginEmail => _loginEmail;

  // passwrod textField controller
  final TextEditingController _loginPassword = TextEditingController();

  TextEditingController get loginPassword => _loginPassword;

  // validate text input
 bool validateLoginFields(BuildContext context) {
    // first checking if all the textfileds are empty or not
    if (_loginEmail.text.isEmpty || _loginPassword.text.isEmpty) {
      Logger().w("Please fill all the fields");
      AlertHelper.showAlert(context, "Validation Error", "Please fill all the fields");
      return false;
    }else if (!_loginEmail.text.contains("@")) {
      Logger().w("Please enter a valid email");
      AlertHelper.showAlert(context, "Validation Error", "Please enter a valid email");
      return false;
    }else if (_loginPassword.text.length < 6) {
      Logger().w("The passwrod must have more than 6 digits");
      AlertHelper.showAlert(context, "Validation Error", "The passwrod must have more than 6 digits");
      return false;
    }else {
      Logger().w("All fields are validated");
      return true;
    }
  }

   // start the login process
  Future<void> startLogin(BuildContext context) async {
    try {
      // validating inputs
      if (validateLoginFields(context)) {
        // start the loader
        setLoading(true);
        //start creating the user
        await _authController.loginUser(context, _loginEmail.text, _loginPassword.text).then(
          (value) => {
            // cleatr the controllers
            _loginEmail.clear(),
            _loginPassword.clear(),

            //stop the loader
            setLoading(false)
          });
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
      AlertHelper.showAlert(context, "SignUp error", "Server error");
    }
  }

  // reset user password

  // email textField controller
  final TextEditingController _resetEmail = TextEditingController();

  TextEditingController get resetEmail => _resetEmail;

  // send the password reset
  Future<void> sendPasswordReset(BuildContext context) async {
    try {
      // validating inputs
      if (_resetEmail.text.isNotEmpty) {
        // start the loader
        setLoading(true);
        //start creating the user
        await _authController.sendEmail(context, _resetEmail.text,).then(
          (value) => {
            // cleatr the controllers
            _resetEmail.clear(),

            //stop the loader
            setLoading(false)
          });
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
      AlertHelper.showAlert(context, "Passwrod Rest Email", "Server error");
    }
  }

  //------- usermodel object to store user objects
  UserModel? _userModel;

  // get the user model
  UserModel? get userModel => _userModel;

  //------- start fetch user data
  Future<void> startFetchUserData(BuildContext context, String uid) async {
    try {
      await _authController.fetchUserdata(context, uid).then(
        (value) {
          // store the user data
          if(value != null) {
            _userModel = value;
            notifyListeners();
          }else {
            AlertHelper.showAlert(context, "User Data Error", "Error fetching user data");
          }
        }
      );
    }catch (e) {
      Logger().e(e);
    }
  }

  //------ pick, upload and update user profile image

  // image picture object
  final ImagePicker picker = ImagePicker();

  // file object to store picked file
  File _image = File("");

  // get picked file
  File get image => _image;

  // Pick an image function
  Future<void> pickImage(BuildContext context) async {
    try{
      final XFile? pickFile = await picker.pickImage(source: ImageSource.camera);

      Logger().w(pickFile?.path);

      // check if the user has picked a file or not
      if (pickFile != null) {
        _image = File(pickFile.path);
        notifyListeners();

        //start the loader
        setLoading(true);

        // start uploading the image
        final imgUrl = await _authController.uploadAndUpdateProfileImage(_image, _userModel!.uid);

        // iF url is not empty, that means the file is uploaded successfully
        if(imgUrl != "") {
          // clear the file object
          _image= File("");
          // update the user model with the new image url
          _userModel!.img = imgUrl;
          notifyListeners();

          //stop the loader
          setLoading(false);
        }else{
          AlertHelper.showAlert(context, "User Image", "Error uploading the image");
        }
      }else {
        Logger().w("No image selected");
      }
    }catch (e) {
      Logger().e(e);
    }
  }
} 