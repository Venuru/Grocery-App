import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/auth_providers.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FadeInLeft(
            child: Consumer<AuthProviders>(builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const CustomText(
                          "Profile", 
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(height: 122.0,),
                        InkWell(
                          onTap: () => value.pickImage(context),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45.0),
                            child: value.isLoading 
                            ? const CircularProgressIndicator()
                            :Image.network(
                                value.userModel?.img ?? AppAssets.profileUrl,
                                height: 200.0,
                                width: 200.0,
                                fit: BoxFit.cover,
                            )
                            // : Image.file(value.image, 
                            //     height: 200.0,
                            //     width: 200.0,
                            //     fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        const SizedBox(height: 18.0,),
                        CustomText(
                          value.userModel?.name ?? "", 
                          fontSize: 18.0,
                        ),
                        CustomText(
                          value.userModel?.email ?? "", 
                          fontSize: 13.0,
                          color: AppColors.ash,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: "Logout", 
                      onTap: () {
                        Provider.of<AuthProviders>(context, listen: false).logOut();
                      }
                    )
                  ],
                );
              },
            )
          ),
        ),
      ),
    );
  }
}