import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
  });

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
              AppAssets.dummyImg,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CustomText(
                "Grapes",
                fontSize: 14.0,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightAsh,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(color: AppColors.ash.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 10,
                    )
                  ] 
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.add)
                    ),
                    const CustomText(
                      "1",
                      fontSize: 14.0,  
                      fontWeight: FontWeight.w600,
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.remove)
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
              
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.orange,
                  size: 18,
                ),
              ),
              const CustomText(
                "152.00",
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