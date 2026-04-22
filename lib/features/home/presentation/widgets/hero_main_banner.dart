import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroMainBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String badgeText;

  const HeroMainBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.badgeText = 'Hot Deal 🔥',
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: (imageUrl.isNotEmpty && imageUrl.startsWith('http'))
              ? NetworkImage(imageUrl) as ImageProvider
              : AssetImage(imageUrl.isEmpty ? 'assets/images/modern_furniture_hero.png' : imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF01B6B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badgeText.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 10 : 12,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              'OFFICE FURNITURE',
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: isMobile ? 12 : 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: isMobile ? 28 : 42,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: isMobile ? 8 : 16),
                  Flexible(
                    child: Text(
                      subtitle,
                      maxLines: isMobile ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: isMobile ? 13 : 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
