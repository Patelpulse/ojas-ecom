import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'WISHLIST',
      child: Container(
        color: Colors.white,
        child: CenteredContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              // Header
              Text(
                'My Wishlist',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Save items for later and never lose track of what you love',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF64748B),
                ),
              ),
              
              const SizedBox(height: 120),
              
              // Empty State
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Large Heart Icon
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 150,
                      color: const Color(0xFF94A3B8).withOpacity(0.5),
                    ),
                    const SizedBox(height: 48),
                    
                    Text(
                      'Your wishlist is empty',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Start adding items you love to keep track of them',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Start Shopping Button
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF01B6B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Start Shopping',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
