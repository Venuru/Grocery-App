import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class RelatedItemTile extends StatelessWidget {
  const RelatedItemTile({
    required this.model,
    super.key,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ProductProvider>(context, listen: false).setProduct = model;
      },
      child: Container(
        width: 90.0,
        height: 90.0,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              model.productImg
            )
          )
        ),
        child: Container(
          height: 24.0,
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: AppColors.lightGreen,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                model.productName,
                fontSize: 11.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 30.0,
                child: CustomText(
                  "RS. ${model.productPrice}",
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}