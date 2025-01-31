import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/components/custom_textfield.dart';
import 'package:grocery_app/providers/admin/admin_provider.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                  ],
                ),
                FadeInDown(
                  child: const CustomText(
                    'Admin Section',
                    fontSize: 25.0,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 41.0,),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return value.productImage.path == "" 
                  ?IconButton(
                    onPressed: () => value.pickProductImage(context), 
                    icon: const Icon(
                      Icons.photo,
                      size: 50.0,
                    )
                  )
                  :InkWell(
                    onTap: () => value.pickProductImage(context),
                    child: Image.file(
                      value.productImage,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  );
                },),
                const SizedBox(height: 20.0,),
                CustomTextField(
                  hintText: "Enter the product name", 
                  labelText: "Prodcut Name",
                  controller: Provider.of<AdminProvider>(context).productName,
                ),
                const SizedBox(height: 7.0,),
                CustomTextField(
                  hintText: "Enter the product description", 
                  labelText: "Product Description",
                  controller: Provider.of<AdminProvider>(context).productDesc,
                ),
                const SizedBox(height: 7.0,),
                CustomTextField(
                  hintText: "Enter the product price", 
                  labelText: "Prodcut Price", 
                  controller: Provider.of<AdminProvider>(context).productPrice,
                ),
                const SizedBox(height: 24.0,),
                Consumer<AdminProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                      isLoading: value.isLoading,
                      text: "Save Product",
                      onTap: () {
                        value.startSaveProductData(context);
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