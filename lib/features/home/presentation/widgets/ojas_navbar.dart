import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/services/session_service.dart';
import 'package:ojas_user/core/controllers/settings_controller.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';

class OjasNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String activeTitle;
  const OjasNavbar({Key? key, this.activeTitle = 'HOME'}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(180);

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return _MobileNavbar(activeTitle: activeTitle);
    }

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

class _MobileNavbar extends StatelessWidget {
  final String activeTitle;
  const _MobileNavbar({required this.activeTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.primaryIndigo,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          Text(
            SettingsController.instance.settings.marketplaceName,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.white, size: 22),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ],
      ),
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
            _TopInfoItem(icon: Icons.phone_outlined, label: SettingsController.instance.settings.supportPhone),
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
          SettingsController.instance.settings.marketplaceName,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 60),
        
        // Menu Items
        _NavItem(key: const ValueKey('nav_home'), title: 'HOME', isActive: activeTitle == 'HOME', onTap: () => Navigator.pushNamed(context, '/')),
        _NavItem(key: const ValueKey('nav_features'), title: 'FEATURES', isActive: activeTitle == 'FEATURES', onTap: () => Navigator.pushNamed(context, '/features')),
        _NavItem(key: const ValueKey('nav_deals'), title: 'DEALS', isActive: activeTitle == 'DEALS', onTap: () => Navigator.pushNamed(context, '/deals')),
        _NavItem(key: const ValueKey('nav_shop'), title: 'SHOP', isActive: activeTitle == 'SHOP', onTap: () => Navigator.pushNamed(context, '/shop')),
        _NavItem(key: const ValueKey('nav_blog'), title: 'BLOG', isActive: activeTitle == 'BLOG', onTap: () => Navigator.pushNamed(context, '/blog')),
        
        const Spacer(),
        
        // Actions
        _IconAction(
          key: const ValueKey('nav_wishlist'),
          icon: Icons.favorite_border, 
          label: 'Wishlist', 
          count: '0', 
          onTap: () => Navigator.pushNamed(context, '/wishlist')
        ),
        const SizedBox(width: 24),
        
        // Cart Button
        ListenableBuilder(
          listenable: CartController.instance,
          builder: (context, _) {
            return ElevatedButton.icon(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: Badge(
                label: Text(CartController.instance.itemCount.toString()),
                isLabelVisible: CartController.instance.itemCount > 0,
                child: const Icon(Icons.shopping_cart_outlined, size: 18),
              ),
              label: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
            );
          },
        ),
        
        const SizedBox(width: 24),
        
        ValueListenableBuilder<UserModel?>(
          valueListenable: SessionService.instance.userNotifier,
          builder: (context, user, _) {
            if (user != null) {
              return _UserInfo(user: user, isActive: activeTitle == 'PROFILE');
            }
            return Row(
              children: [
                const _AuthLink(key: ValueKey('nav_login'), title: 'Login'),
                const SizedBox(width: 16),
                _RegisterButton(key: const ValueKey('nav_register')),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserModel user;
  final bool isActive;
  const _UserInfo({required this.user, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/profile', arguments: user),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.withOpacity(0.5), width: 2),
              ),
              child: ClipOval(
                child: user.photo != null && user.photo!.isNotEmpty
                  ? Image.network(
                      user.photo!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white, size: 20),
                    )
                  : const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.inter(
                    color: isActive ? AppColors.accentOrange : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.role.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: isActive ? AppColors.accentOrange.withOpacity(0.8) : Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
  const _NavItem({Key? key, required this.title, this.isActive = false, this.onTap}) : super(key: key);

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
    Key? key,
    required this.icon, 
    required this.label, 
    required this.count,
    this.onTap,
  }) : super(key: key);

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
  const _AuthLink({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/login'),
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
  const _RegisterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/register'),
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
