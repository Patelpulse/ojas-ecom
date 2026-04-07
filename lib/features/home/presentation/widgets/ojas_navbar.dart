import 'package:flutter/material.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class OjasNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String activeTitle;
  const OjasNavbar({super.key, this.activeTitle = 'HOME'});

  @override
  Size get preferredSize => const Size.fromHeight(180);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Top Info Bar
        Container(
          height: 40,
          color: AppColors.primaryIndigo.withOpacity(0.95),
          child: const CenteredContent(
            horizontalPadding: 20,
            child: _TopInfoBarContent(),
          ),
        ),
        
        // 2. Main Navigation Bar
        Container(
          height: 70,
          color: AppColors.primaryIndigo,
          child: CenteredContent(
            horizontalPadding: 20,
            child: _MainNavBarContent(activeTitle: activeTitle),
          ),
        ),
        
        // 3. Search & Vendor Bar
        Container(
          height: 70,
          color: AppColors.primaryIndigo.withOpacity(0.98),
          child: const CenteredContent(
            horizontalPadding: 20,
            child: _SearchBarRowContent(),
          ),
        ),
      ],
    );
  }
}


class _TopInfoBarContent extends StatelessWidget {
  const _TopInfoBarContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.flash_on, color: AppColors.accentOrange, size: 16),
            const SizedBox(width: 8),
            Text(
              'Good Deals Every Day!',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(width: 16),
            Text(
              'Learn More',
              style: GoogleFonts.inter(
                color: AppColors.accentOrange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _TopInfoItem(
              icon: Icons.location_on_outlined, 
              label: 'Track Order',
              onTap: () => Navigator.pushNamed(context, '/orders'),
            ),
            const SizedBox(width: 24),
            const _TopInfoItem(icon: Icons.phone_outlined, label: '+91 9087654321'),
          ],
        ),
      ],
    );
  }
}

class _TopInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _TopInfoItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MainNavBarContent extends StatelessWidget {
  final String activeTitle;
  const _MainNavBarContent({required this.activeTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Logo
        Text(
          'OJAS',
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 60),
        
        // Menu Items
        _NavItem(title: 'HOME', isActive: activeTitle == 'HOME', onTap: () => Navigator.pushNamed(context, '/')),
        _NavItem(title: 'FEATURES', isActive: activeTitle == 'FEATURES', onTap: () => Navigator.pushNamed(context, '/features')),
        _NavItem(title: 'DEALS', isActive: activeTitle == 'DEALS', onTap: () => Navigator.pushNamed(context, '/deals')),
        _NavItem(title: 'SHOP', isActive: activeTitle == 'SHOP', onTap: () => Navigator.pushNamed(context, '/shop')),
        _NavItem(title: 'BLOG', isActive: activeTitle == 'BLOG', onTap: () => Navigator.pushNamed(context, '/blog')),
        
        const Spacer(),
        
        // Actions
        _IconAction(
          icon: Icons.favorite_border, 
          label: 'Wishlist', 
          count: '0', 
          onTap: () => Navigator.pushNamed(context, '/wishlist')
        ),
        const SizedBox(width: 24),
        
        // Cart Button
        ElevatedButton.icon(
          onPressed: () => Scaffold.of(context).openEndDrawer(),

          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.shopping_cart_outlined, size: 18),
          label: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        
        const SizedBox(width: 24),
        const _AuthLink(title: 'Login'),
        const SizedBox(width: 16),
        _RegisterButton(),
      ],
    );
  }
}


class _SearchBarRowContent extends StatelessWidget {
  const _SearchBarRowContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Become Vendor Button
        ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/become-vendor'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.storefront_outlined, size: 20),
          label: const Text('BECOME VENDOR', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        
        const SizedBox(width: 24),
        
        // Search Field
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your keyword...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onTap;
  const _NavItem({required this.title, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.accentOrange : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: isActive ? AppColors.accentOrange : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final VoidCallback? onTap;
  
  const _IconAction({
    required this.icon, 
    required this.label, 
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              '$label $count',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthLink extends StatelessWidget {
  final String title;
  const _AuthLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'api/user/login'),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          title,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'api/user/registration'),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Register',
          style: GoogleFonts.inter(
            color: AppColors.primaryIndigo,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
