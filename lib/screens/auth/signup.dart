import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/app_logo.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/components/custom_textfield.dart';
import 'package:grocery_app/providers/auth_providers.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                const SizedBox(height: 20.0,),
                FadeInDown(
                  child: const CustomText(
                    'SignUp',
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
                  hintText: "Enter your name here", 
                  labelText: "Name",
                  controller: Provider.of<AuthProviders>(context).name,
                ),
                const SizedBox(height: 7.0,),
                CustomTextField(
                  hintText: "Enter your email here", 
                  labelText: "Email",
                  controller: Provider.of<AuthProviders>(context).email,
                ),
                const SizedBox(height: 7.0,),
                CustomTextField(
                  hintText: "Enter your password here", 
                  labelText: "Password", 
                  isObsecure: true,
                  controller: Provider.of<AuthProviders>(context).password,
                ),
                const SizedBox(height: 12.0,),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                    },
                    child: const CustomText(
                      'Already have an account?',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0,),
                Consumer<AuthProviders>(
                  builder: (context, value, child) {
                    return CustomButton(
                      isLoading: value.isLoading,
                      text: "SignUp",
                      onTap: () {
                        value.startSingup(context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}