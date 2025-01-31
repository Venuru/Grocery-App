import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/home/product_provider.dart';
import 'package:grocery_app/screens/main/favourites/widgets/favourite_tile.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Center(
            child: CustomText(
              "Favourites", 
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            )
          ),
          const SizedBox(height: 18.0,),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, value, child) {
                return value.favProducts.isEmpty 
                ? const Center(child: CustomText("No favourite Items")) 
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return FavouriteTile(
                        productModel: value.favProducts[index],
                      );
                    }, 
                    separatorBuilder: (context, index) => const SizedBox(height: 10.0,), 
                    itemCount: value.favProducts.length,
                  );
              },
            )
          )
        ],
      ),
    );
  }
}