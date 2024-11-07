import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/screens/main/product_details/product_details.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAssets.getIconName(
                      "menu-icon.svg"
                    )
                  ),
                  SvgPicture.asset(
                    AppAssets.getIconName(
                      "cart-icon.svg"
                    )
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              const CustomText(
                "Vegetable",
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 41.0,),
      
              // Product Grid
              const ProductGrid()
            ],
          ),
        )
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadeInLeft(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            childAspectRatio: 0.75,
            crossAxisSpacing: 19.0,
            mainAxisSpacing: 44.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ProductTile();
          },
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Helpers.navigateTo(context, const ProductDetails());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12.0),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              AppAssets.dummyImg
            )
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.ash,
              ),
            ),
            Container(
              height: 38.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                 color: AppColors.lightGreen,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 65.0,
                    child: CustomText(
                      "Pumking",
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                    "RS.120.00",
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}