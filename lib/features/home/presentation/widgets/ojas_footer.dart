import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/controllers/settings_controller.dart';
import 'package:provider/provider.dart';

class OjasFooter extends StatelessWidget {
  const OjasFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final settings = SettingsController.instance.settings;

    return Container(
      color: const Color(0xFF1E1B4B), // Premium Dark Indigo matching navbar
      padding: EdgeInsets.only(top: isMobile ? 40 : 80, bottom: 40),
      child: CenteredContent(
        horizontalPadding: isMobile ? 16 : 40,
        child: Column(
          children: [
            // TOP ROW: Responsive Grid
            Wrap(
              spacing: 40,
              runSpacing: 40,
              children: [
                // Col 1: Branding
                SizedBox(
                  width: isMobile ? double.infinity : 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogo(settings.marketplaceName),
                      const SizedBox(height: 20),
                      Text(
                        settings.tagline.isNotEmpty 
                          ? settings.tagline 
                          : 'Your trusted marketplace for quality products from verified vendors worldwide. Discover amazing deals and exceptional service.',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          height: 1.6,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _socialIcon(Icons.facebook),
                          _socialIcon(Icons.camera_alt),
                          _socialIcon(Icons.share),
                          _socialIcon(Icons.play_circle_outline),
                        ],
                      )
                    ],
                  ),
                ),
                
                // Col 2: Quick Links
                SizedBox(
                  width: isMobile ? (MediaQuery.of(context).size.width - 72) / 2 : 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('QUICK LINKS'),
                      _footerLink(context, 'Home', route: '/'),
                      _footerLink(context, 'About Us'),
                      _footerLink(context, 'Shop', route: '/shop'),
                      _footerLink(context, 'Offers', route: '/deals'),
                      const SizedBox(height: 8),
                      _vendorBadge(),
                    ],
                  ),
                ),
                
                // Col 3: Customer Service
                SizedBox(
                  width: isMobile ? (MediaQuery.of(context).size.width - 72) / 2 : 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('CUSTOMER SERVICE'),
                      _footerLink(context, 'Returns & Refunds', route: '/returns'),
                      _footerLink(context, 'Track Orders', route: '/orders'),
                      _footerLink(context, 'Help Center', route: '/contact'),
                    ],
                  ),
                ),
                
                // Col 4: Get In Touch
                SizedBox(
                  width: isMobile ? double.infinity : 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('GET IN TOUCH'),
                      _contactInfo(Icons.phone_outlined, settings.contactPhone),
                      _contactInfo(Icons.email_outlined, settings.contactEmail),
                      _contactInfo(Icons.location_on_outlined, settings.contactAddress),
                      const SizedBox(height: 24),
                      _columnTitle('LEGAL'),
                      _footerLink(context, 'Terms & Conditions', route: '/terms'),
                      _footerLink(context, 'Privacy Policy', route: '/privacy'),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 48),
            Divider(color: Colors.white10, thickness: 1),
            const SizedBox(height: 24),
            
            // MIDDLE ROW: Copyright
            Text(
              settings.footerMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
            ),
            
            const SizedBox(height: 48),
            
            // BOTTOM ROW: Brands
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: List.generate(isMobile ? 3 : 5, (index) {
                bool isBoat = index % 2 == 0;
                return _brandCard(isBoat);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(String name) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF01B6B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(name.isNotEmpty ? name[0] : 'O', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        const SizedBox(width: 8),
        Text(
          name.isNotEmpty ? name : 'OJAS',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _vendorBadge() {
    return Row(
      children: [
        const Icon(Icons.storefront, color: Colors.deepOrange, size: 16),
        const SizedBox(width: 8),
        Text(
          'Become Vendor',
          style: GoogleFonts.inter(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _brandCard(bool isBoat) {
    return Container(
      width: 140,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Center(
        child: isBoat
            ? RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black87),
                  children: [
                    const TextSpan(text: 'bo'),
                    TextSpan(text: 'A', style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold)),
                    const TextSpan(text: 't'),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.black87, size: 20),
                  Text('SHOP SMART', style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: Colors.pink, fontSize: 11)),
                ],
              ),
      ),
    );
  }

  Widget _columnTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _footerLink(BuildContext context, String text, {String? route, VoidCallback? onTap}) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final bool isActive = route != null && currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _FooterLinkItem(
        text: text,
        isActive: isActive,
        onTap: onTap ?? (route != null ? () => Navigator.pushNamed(context, route) : null),
      ),
    );
  }

  Widget _contactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Icon(icon, color: Colors.white70, size: 20),
    );
  }
  
  Widget _dot(Color color) {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _FooterLinkItem extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _FooterLinkItem({
    required this.text,
    required this.isActive,
    this.onTap,
  });

  @override
  State<_FooterLinkItem> createState() => _FooterLinkItemState();
}

class _FooterLinkItemState extends State<_FooterLinkItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Primary pink color from branding, matches navbar hover
    const Color activeColor = Color(0xFFF01B6B);
    const Color normalColor = Colors.white70;
    const Color hoverColor = Colors.white;

    return InkWell(
      onTap: widget.onTap,
      onHover: (value) => setState(() => _isHovered = value),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: GoogleFonts.inter(
              color: widget.isActive ? activeColor : (_isHovered ? hoverColor : normalColor),
              fontSize: 13,
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (widget.isActive)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 1.5,
              width: 15,
              color: activeColor,
            ),
        ],
      ),
    );
  }
}
