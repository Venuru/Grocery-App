import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/home/order_provider.dart';
import 'package:grocery_app/screens/main/orders/widgets/order_tile.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Center(
            child: CustomText(
              "Orders", 
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            )
          ),
          const SizedBox(height: 18.0,),
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, value, child) {
                return value.orders.isEmpty 
                ? const Center(child: CustomText("No Orders")) 
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderTile(
                        orderModel: value.orders[index], 
                        index: index,
                      );
                    }, 
                    separatorBuilder: (context, index) => const SizedBox(height: 10.0,), 
                    itemCount: value.orders.length,
                  );
              },
            )
          )
        ],
      ),
    );
  }
}