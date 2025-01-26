import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        height: 300,
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CartAmountRow(
                  name: "Item total",
                  amount: value.getCartTotalItemCount.toString(),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const CartAmountRow(
                  name: "Discount",
                  amount: "Rs.-10",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const CartAmountRow(
                  name: "Tax",
                  amount: "Rs.20",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                CartAmountRow(
                  name: "Total",
                  amount: "Rs. ${value.getCartTotalPrice}0",
                  fontSize: 18.0,
                  fontWeight: true,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                    text: "Place Order",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const DialogBoxContainer();
                        },
                      );
                    })
              ],
            );
          },
        ));
  }
}

class DialogBoxContainer extends StatelessWidget {
  const DialogBoxContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 361.0,
            width: 300.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.getImgName("dialog-img.png")),
                const SizedBox(
                  height: 30.0,
                ),
                const CustomText(
                  "Thanks for Buying\nFrom Us!",
                  fontSize: 20.0,
                  color: AppColors.darkGreen,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Positioned(
            bottom: -23,
            child: CustomButton(
                text: "See your order", btnWidth: 200.0, onTap: () {}),
          )
        ],
      ),
    );
  }
}

class CartAmountRow extends StatelessWidget {
  const CartAmountRow({
    super.key,
    required this.name,
    required this.amount,
    this.fontSize = 14.0,
    this.fontWeight = false,
  });

  final String name;
  final String amount;
  final double fontSize;
  final bool fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          name,
          fontSize: fontSize,
          fontWeight: fontWeight ? FontWeight.bold : FontWeight.normal,
        ),
        CustomText(
          amount,
          fontSize: fontSize,
          fontWeight: fontWeight ? FontWeight.bold : FontWeight.normal,
        ),
      ],
    );
  }
}
