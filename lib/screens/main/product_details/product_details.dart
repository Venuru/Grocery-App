import 'package:flutter/material.dart';
import 'package:grocery_app/components/cart_button.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:grocery_app/screens/main/product_details/widgets/related_item_tile.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/size_config.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.getScreenWidth(context),
        height: SizeConfig.getScreenHeight(context),
        child: Stack(
          children: [
            const UpperSection(),
            const Positioned(
              top: 256.0,
              child: ProductDetailsSection(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  const CartButton(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Consumer<ProductProvider>(
                      builder: (context, value, child) {
                        return CustomButton(
                          text: "Add to cart", 
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false).addToCart(value.productModel, context);
                          }
                        );
                      },
                    )
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.getScreenWidth(context),
      height: SizeConfig.getScreenHeight(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.0), 
          topRight: Radius.circular(34.0)
        )
      ),
      padding: const EdgeInsets.fromLTRB(30, 34, 30, 0),
      child: Consumer<ProductProvider>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  value.productModel.productName,
                  fontSize: 20.0,  
                  fontWeight: FontWeight.w600,
                ),
                const CounterSection(),
              ],
            ),
            const SizedBox(height: 21.0,),
            CustomText(
              "RS. ${value.productModel.productPrice}",
              fontSize: 14.0,
            ),
            const SizedBox(height: 28.0,),
            CustomText(
              value.productModel.productDec,
              textAlign: TextAlign.justify,
              fontSize: 13.0,
            ),
            const SizedBox(height: 28.0,),
            const CustomText(
              "Related item",
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGreen,
            ),
            const SizedBox(height: 20.0,),
            const RelatedItemSection(),
          ],
        );
      },)
    );
  }
}

class RelatedItemSection extends StatelessWidget {
  const RelatedItemSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      child: Consumer<ProductProvider>(
        builder: (context, value, child,) {
          return ListView.separated(
            itemCount: value.relatedProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return RelatedItemTile(model: value.relatedProducts[index],);
            },
          separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
          );
        }
      )
    );
  }
}

class CounterSection extends StatelessWidget {
  const CounterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.ash,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Row(
            children: [
              IconButton(
                onPressed: () => value.increaseCounter(), 
                icon: const Icon(Icons.add)
              ),
              const SizedBox(width: 8.0,),
              CustomText(
                "${value.counter}",
                fontSize: 14.0,  
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 8.0,),
              IconButton(
                onPressed: () => value.decreaseCounter(), 
                icon: const Icon(Icons.remove)
              ),
            ],
          );
        },
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  const UpperSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.0,
      alignment: Alignment.topLeft,
      width: SizeConfig.getScreenWidth(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            Provider.of<ProductProvider>(context).productModel.productImg,
          ),
          fit: BoxFit.cover,
        )
      ),
      child: const SafeArea(
        child:  Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        )),
    );
  }
}