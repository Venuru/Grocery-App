import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/providers/home/product_provider.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class FavouriteTile extends StatelessWidget {
  const FavouriteTile({
    super.key,
    required this.productModel
  });

  final ProductModel productModel;

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
              productModel.productImg,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16.0,),
          CustomText(
            productModel.productName,
            fontSize: 14.0,
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false).addToFav(productModel, context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.orange,
                  size: 18,
                ),
              ),
              CustomText(
                "Rs. ${productModel.productPrice}",
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