import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mas_market/Pages/main/home/home_screen.dart';
import 'package:mas_market/Pages/main/profiled.dart';
import 'package:mas_market/core/theme/app_colors.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currectIndex = 0;
  final List<Widget> pages = [HomeScreen(), Scaffold(), Profiled(), Scaffold()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: pages[currectIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(color: AppColors.primary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Iconsax.home_15, 'A', 0),
            SizedBox(width: 10),
            _buildNavItem(Iconsax.heart, 'B', 1),
            SizedBox(width: 90),
            _buildNavItem(Icons.person_outline, 'C', 2),
            SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildNavItem(Iconsax.shopping_cart, 'D', 3),
                Positioned(
                  right: -10,
                  top: 12,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.softPurple,
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightGray,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 145,
                  top: -25,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.textSecondary,
                    child: Icon(
                      CupertinoIcons.search,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = currectIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          currectIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? AppColors.paleGold : AppColors.background,
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor:
                isSelected ? AppColors.paleGold : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
