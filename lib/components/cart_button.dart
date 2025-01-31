import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/home/cart_provider.dart';
import 'package:grocery_app/screens/main/cart/cart.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return  badges.Badge(
          badgeContent: CustomText(
            value.cartItems.length.toString(),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: AppColors.primaryColor
          ),
          child: InkWell(
            onTap: () {
              Helpers.navigateTo(context, const Cart());
            },
            child: SvgPicture.asset(
              AppAssets.getIconName("cart-icon.svg")
            ),
          ),
        );
      }
    );
  }
}
