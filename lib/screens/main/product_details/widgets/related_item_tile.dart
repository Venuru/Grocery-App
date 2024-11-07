import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class RelatedItemTile extends StatelessWidget {
  const RelatedItemTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        width: 90.0,
        height: 90.0,
        alignment: Alignment.bottomCenter,
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
        child: Container(
          height: 24.0,
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: AppColors.lightGreen,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Pumking",
                fontSize: 11.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 30.0,
                child: CustomText(
                  "RS.120.00",
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