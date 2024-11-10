import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CartAmountRow(
            name: "Item total",
            amount: "Rs.20.49",
          ),
          const SizedBox(height: 12.0,),
          const CartAmountRow(
            name: "Discount",
            amount: "Rs.-10",
          ),
          const SizedBox(height: 12.0,),
          const CartAmountRow(
            name: "Tax",
            amount: "Rs.20",
          ),
          const SizedBox(height: 12.0,),
          const CartAmountRow(
            name: "Total",
            amount: "Rs.20.49",
            fontSize: 18.0,
            fontWeight: true,
          ),
          const SizedBox(height: 30.0,),
          CustomButton(
            text: "Place Order", 
            onTap: () {
              
            })
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
          fontWeight: fontWeight? FontWeight.bold : FontWeight.normal,
        ),
        CustomText(
          amount,
          fontSize: fontSize,
          fontWeight: fontWeight? FontWeight.bold : FontWeight.normal,
        ),
      ],
    );
  }
}