import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_back_button.dart';
import 'package:grocery_app/components/custom_button.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/screens/main/product_details/widgets/related_item_tile.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';
import 'package:grocery_app/utils/helpers/size_config.dart';

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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: CustomButton(
                  text: "Add to cart", 
                  onTap: () {}
                ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Grapes",
                fontSize: 20.0,  
                fontWeight: FontWeight.w600,
              ),
              CounterSection(),
            ],
          ),
          const SizedBox(height: 21.0,),
          const CustomText(
            "RS. 15.00",
            fontSize: 14.0,
          ),
          const SizedBox(height: 28.0,),
          const CustomText(
            "Grapes  is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution.",
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
          SizedBox(
            height: 90.0,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const RelatedItemTile();
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
            ),
          ),
        ],
      ),
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
      child: Row(
        children: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.add)
          ),
          const SizedBox(width: 8.0,),
          const CustomText(
            "1",
            fontSize: 14.0,  
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(width: 8.0,),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.remove)
          ),
        ],
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            AppAssets.dummyImg
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