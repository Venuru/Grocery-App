import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        "Orders", 
        fontSize: 30.0,
      )
    );
  }
}