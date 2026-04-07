import 'package:flutter/material.dart';
import 'package:ojas_user/features/home/presentation/widgets/ojas_navbar.dart';
import 'package:ojas_user/features/home/presentation/widgets/ojas_footer.dart';
import 'package:ojas_user/features/home/presentation/widgets/cart_drawer.dart';
import 'package:ojas_user/core/constants/app_colors.dart';

class OjasLayout extends StatelessWidget {
  final Widget child;
  final String activeTitle;
  const OjasLayout({super.key, required this.child, this.activeTitle = 'HOME'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimaryLight,
      endDrawer: const CartDrawer(),
      body: Stack(
        children: [
          // 1. Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 180), // Navbar height
                  child,
                  const OjasFooter(), // Included here so it scrolls with content, but is persistent across pages
                ],
              ),
            ),
          ),
          
          // 2. Fixed Navbar (Sticky at top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (context) => OjasNavbar(activeTitle: activeTitle),
            ),
          ),
        ],
      ),
    );
  }
}


