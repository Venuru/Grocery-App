import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/app_logo.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/components/custom_textfield.dart';
import 'package:grocery_app/providers/auth_providers.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                  child: CustomBackButton()
                ),
                const SizedBox(height: 20.0,),
                FadeInDown(
                  child: const CustomText(
                    'Forgot Password',
                    fontSize: 25.0,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 41.0,),
                FadeInUp(
                  child: const AppLogo(),
                ),
                const SizedBox(height: 100.0,),
                const CustomText(
                  "Please, enter your email address. You will receive\n a link to create a new password via email.",
                  fontSize: 14.0,
                ),
                const SizedBox(height: 16.0,),
                CustomTextField(
                  hintText: "Enter your email here", 
                  labelText: "Email",
                  controller: Provider.of<AuthProviders>(context).resetEmail,
                ),
                const SizedBox(height: 44.0,),
                Consumer<AuthProviders>(
                  builder: (context, value, child) {
                    return CustomButton(
                      text: "Send",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.sendPasswordReset(context);
                      },
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



