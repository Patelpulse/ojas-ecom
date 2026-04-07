import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class OjasFooter extends StatelessWidget {
  const OjasFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F6F8), // Soft light gray background
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      child: CenteredContent(
        child: Column(
          children: [
            // TOP ROW: 4 Columns
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Col 1: Branding
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('O', style: TextStyle(color: Color(0xFFF01B6B), fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'OJAS',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Your trusted marketplace for quality products from verified vendors worldwide. Discover amazing deals and exceptional service with every purchase.',
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
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
                const SizedBox(width: 40),
                
                // Col 2: Quick Links
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('QUICK LINKS'),
                      _footerLink(context, 'Home', route: '/'),
                      _footerLink(context, 'About Us'),
                      _footerLink(context, 'Shop', route: '/shop'),
                      _footerLink(context, 'Offers', route: '/deals'),
                      _footerLink(context, 'Contact'),
                      const SizedBox(height: 8),
                      Row(
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
                      ),
                    ],
                  ),
                ),
                
                // Col 3: Customer Service
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('CUSTOMER SERVICE'),
                      _footerLink(context, 'Returns & Refunds', route: '/returns'),
                      _footerLink(context, 'Track Orders', route: '/orders'),
                      _footerLink(context, 'Help Center'),
                    ],
                  ),
                ),
                
                // Col 4: Get In Touch & Legal
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnTitle('GET IN TOUCH'),
                      _contactInfo(Icons.phone_outlined, '+91 9087654321'),
                      _contactInfo(Icons.email_outlined, 'support@ojas.com'),
                      _contactInfo(Icons.location_on_outlined, 'Ghaziabad, Uttar Pradesh'),
                      const SizedBox(height: 32),
                      _columnTitle('LEGAL'),
                      _footerLink(context, 'Terms & Conditions', route: '/terms'),
                      _footerLink(context, 'Privacy Policy', route: '/privacy'),
                      _footerLink(context, 'Cookie Policy'),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 48),
            Divider(color: Colors.grey[300], thickness: 1),
            const SizedBox(height: 24),
            
            // MIDDLE ROW: Copyright
            Text(
              '© 2026 OJAS. All rights reserved. | Made with ❤️ for amazing customers',
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12),
            ),
            
            const SizedBox(height: 48),
            
            // BOTTOM ROW: Brands
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                // Mocking the boat / shop smart cards
                bool isBoat = index % 2 == 0;
                return Container(
                  width: 140,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: isBoat
                        ? RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal, color: Colors.black87),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.shopping_cart, color: Colors.black87, size: 24),
                                  const SizedBox(width: 4),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          _dot(Colors.deepOrange),
                                          _dot(Colors.pink),
                                          _dot(Colors.blue),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _dot(Colors.green),
                                          _dot(Colors.purple),
                                          _dot(Colors.amber),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('SHOP SMART', style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: Colors.pink, fontSize: 13, letterSpacing: -0.5)),
                              const Text('E-COMMERCE', style: TextStyle(fontSize: 6, color: Colors.grey, letterSpacing: 1)),
                            ],
                          ),
                  ),
                );
              }),
            ),
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
          color: Colors.black87,
          letterSpacing: 0.5,
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
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.grey[700],
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
      child: Icon(icon, color: Colors.grey[600], size: 20),
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
    final Color normalColor = Colors.grey[700]!;
    const Color hoverColor = Color(0xFFF01B6B);

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
