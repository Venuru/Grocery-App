import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/screens/main/cart/widgets/bottom_section.dart';
import 'package:grocery_app/screens/main/cart/widgets/cart_tile.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(),
                  CustomText(
                    "Cart",
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  Icon(
                    Icons.abc,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(height: 18.0,),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return const CartTile();
                  }, 
                  separatorBuilder: (context, index) => const SizedBox(height: 10.0,), 
                  itemCount: 7
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomSection(),
    );
  }
}

