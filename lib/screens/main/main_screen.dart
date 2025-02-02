import 'package:flutter/material.dart';
import 'package:grocery_app/screens/main/Profile/profile.dart';
import 'package:grocery_app/screens/main/favourites/favourites.dart';
import 'package:grocery_app/screens/main/home/home.dart';
import 'package:grocery_app/screens/main/orders/orders.dart';
import 'package:grocery_app/utils/constants/app_assets.dart';
import 'package:grocery_app/utils/constants/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // to store the active bottom bar index
  int _activeIndex = 0;

  // trigger wghen bottom bar item is clicked
  void onItemTap(int i) {
    setState(() {
        _activeIndex = i;
    });
  }

  // screens list
  final List<Widget> _screens = const [
    Home(),
    Favourites(),
    Orders(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeIndex],
      bottomNavigationBar: SizedBox(
        height: 83.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavTile(
              icon: Icons.home,
              isActive: _activeIndex == 0,
              onPressed: () => onItemTap(0)
            ),
            BottomNavTile(
              icon: Icons.favorite_border,
              isActive: _activeIndex == 1,
              onPressed: () => onItemTap(1),
            ),
            BottomNavTile(
              icon: Icons.menu_book,
              isActive: _activeIndex == 2,
              onPressed: () => onItemTap(2),
            ),
            BottomNavTile(
              icon: Icons.person,
              isActive: _activeIndex == 3,
              onPressed: () => onItemTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  const BottomNavTile({
    super.key,
    required this.isActive,
    required this.icon,
    required this.onPressed
  }) ;

  final bool isActive;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: Icon(
        icon, 
        size: 33.0,
        color: isActive ? AppColors.primaryColor: AppColors.ash,
      )
    );
  }
}