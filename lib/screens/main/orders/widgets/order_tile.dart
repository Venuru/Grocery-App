import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.orderModel,
    required this.index
  });

  final OrderModel orderModel;
  final int index;

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
              orderModel.items.first.productModel.productImg,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Order no ${ index + 1 }",
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "Quantity ${  orderModel.items.length}",
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CustomText(
                  orderModel.orderStatus,
                  color: AppColors.white,
                )
              ),
              CustomText(
                "Rs. ${orderModel.total}",
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