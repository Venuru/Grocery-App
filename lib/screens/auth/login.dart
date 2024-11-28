import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/components/app_logo.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/components/custom_textfield.dart';
import 'package:grocery_app/screens/auth/forgot_password.dart';
import 'package:grocery_app/screens/main/main_screen.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // email textField controller
  final TextEditingController _email = TextEditingController();

  // email textField controller
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
                const SizedBox(height: 20.0,),
                FadeInDown(
                  child: const CustomText(
                    'Login',
                    fontSize: 25.0,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 41.0,),
                FadeInUp(
                  child: const AppLogo(),
                ),
                const SizedBox(height: 30.0,),
                CustomTextField(
                  hintText: "Enter your email here", 
                  labelText: "Email", 
                  controller: _email,
                ),
                const SizedBox(height: 7.0,),
                CustomTextField(
                  hintText: "Enter your password here", 
                  labelText: "Password", 
                  isObsecure: true,
                  controller: _password,
                ),
                const SizedBox(height: 12.0,),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Helpers.navigateTo(context, const ForgotPassword());
                    },
                    child: const CustomText(
                      'Forgot your password?',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0,),
                CustomButton(
                  text: 'Login', 
                  onTap: () {
                    if (validateFields()) {
                      
                    }
                  }
                ),
                const SizedBox(height: 23.0,),
                const CustomText(
                  'Or login with social account',
                  fontSize: 14.0,
                ),
                const SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(iconName: 'google.svg', onTap: () {},),
                    const SizedBox(width: 16.0,),
                    SocialButton(iconName: 'facebook.svg', onTap: () {},)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

   bool validateFields() {
    // first checking if all the textfileds are empty or not
    if (_email.text.isEmpty || _password.text.isEmpty) {
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
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.iconName,
    required this.onTap,
    super.key,
  });

  final String iconName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: AppColors.ash.withOpacity(0.3),
              offset: const Offset(0, 0),
              blurRadius: 10,
            )
          ]
        ),
        child: SvgPicture.asset(
          height: 70,
          AppAssets.getIconName(iconName)),
      ),
    );
  }
}