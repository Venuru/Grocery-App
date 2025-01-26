import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/models/cart_item_model.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cartItemModel
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(color: AppColors.ash.withOpacity(0.3),
            offset: const Offset(0, 0),
            blurRadius: 10,
          )
        ]  
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              cartItemModel.productModel.productImg,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                cartItemModel.productModel.productName,
                fontSize: 14.0,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightAsh,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(color: AppColors.ash.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 10,
                    )
                  ] 
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).increaseCartItemAmount(cartItemModel.id);
                      }, 
                      icon: const Icon(Icons.add)
                    ),
                    CustomText(
                      cartItemModel.productAmount.toString(),
                      fontSize: 14.0,  
                      fontWeight: FontWeight.w600,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).decreaseCartItemAmount(cartItemModel.id);
                      }, 
                      icon: const Icon(Icons.remove)
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Provider.of<CartProvider>(context, listen: false).removeCartItem(cartItemModel.id);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.orange,
                  size: 18,
                ),
              ),
              CustomText(
                "Rs. ${cartItemModel.subTotal}",
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              )
            ],
          )
        ],
      ),
    );
  }
}