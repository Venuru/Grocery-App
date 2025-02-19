import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/components/cart_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/providers/home/cart_provider.dart';
import 'package:grocery_app/providers/home/product_provider.dart';
import 'package:grocery_app/screens/main/product_details/product_details.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/helpers.dart';
import 'package:provider/provider.dart';

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
                  const CartButton()
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
        child: Consumer<ProductProvider>(builder : (context, value, child) { 
          return value.isLoading 
          ? const Center(child: CircularProgressIndicator())
          : value.products.isEmpty
            ? const Center(child: CustomText("No products")) 
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 19.0,
                  mainAxisSpacing: 44.0,
                ),
                itemCount: value.products.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    productModel: value.products[index],
                  );
                },
            );
          }
        )
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // set selected product model on clicked
        Provider.of<ProductProvider>(context, listen: false).setProduct = productModel;

        // clear the cart counter
        Provider.of<CartProvider>(context, listen: false).clearAmount();

        // navigate to the product details screen
        Helpers.navigateTo(context, const ProductDetails());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              productModel.productImg
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
              child: Consumer<ProductProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () => value.addToFav(productModel, context),
                    child: value.favProducts.contains(productModel) 
                    ? const Icon(
                      Icons.favorite,
                      color: AppColors.orange,
                    )
                    : const Icon(
                      Icons.favorite_border,
                      color: AppColors.ash,
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 38.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                 color: AppColors.lightGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 65.0,
                    child: CustomText(
                      productModel.productName,
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                    "RS.${productModel.productPrice}.00",
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