import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekendDealsSlider extends StatelessWidget {
  const WeekendDealsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.4), // Dark overlay
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD81B60),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_offer_outlined, color: Colors.white, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          'LIMITED OFFER',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Weekend Deals',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Accessories • Speakers • Smart Home',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Navigation Arrows
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _navButton(Icons.arrow_back),
              ),
            ),
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _navButton(Icons.arrow_forward),
              ),
            ),
            
            // Highlight Dots
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(Colors.white.withOpacity(0.5), width: 8),
                  const SizedBox(width: 6),
                  _dot(Colors.white, width: 24), // Active dot
                  const SizedBox(width: 6),
                  _dot(Colors.white.withOpacity(0.5), width: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Icon(icon, color: Colors.black87, size: 20),
    );
  }

  Widget _dot(Color color, {required double width}) {
    return Container(
      width: width,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
