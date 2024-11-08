import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        "Favourites", 
        fontSize: 30.0,
      )
    );
  }
}