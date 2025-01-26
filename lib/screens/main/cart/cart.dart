import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/screens/main/cart/widgets/bottom_section.dart';
import 'package:grocery_app/screens/main/cart/widgets/cart_tile.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

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
                child: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return value.cartItems.isEmpty 
                    ? const Center(child: CustomText("No Cart Item")) 
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return CartTile(cartItemModel: value.cartItems[index],);
                        }, 
                        separatorBuilder: (context, index) => const SizedBox(height: 10.0,), 
                        itemCount: value.cartItems.length,
                      );
                  },
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomSection(),
    );
  }
}

