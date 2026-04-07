import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class BecomeVendorBanner extends StatelessWidget {
  const BecomeVendorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          width: double.infinity,
          height: 420, // Increased height to prevent overflow
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                const Color(0xFFFDE8F1).withOpacity(0.5), // Very soft pinkish tint on right
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Stack(
            children: [
              // Content Left Side
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 40.0, bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.discount_outlined, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(
                            '20% FLAT DISCOUNT',
                            style: GoogleFonts.inter(
                              color: Colors.grey[800],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Title
                    Text(
                      'Become a Vendor.\nGrow Your Business With Us.',
                      style: GoogleFonts.outfit(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A), // Dark slate
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Subtitle
                    SizedBox(
                      width: 500,
                      child: Text(
                        'Get your storefront, reach millions of customers, and enjoy fast payouts, promotion tools, and dedicated support.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Buttons
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.storefront, size: 18),
                          label: const Text('Become a Vendor'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F172A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0F172A),
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Explore now', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Images Right Side
              Positioned(
                right: 80,
                top: 20,
                bottom: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Apple Watch Image
                    Transform.translate(
                      offset: const Offset(40, -20),
                      child: Transform.rotate(
                        angle: -0.1, // Slight rotation
                        child: Container(
                          width: 200,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500'), // Apple Watch
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Xbox Controller Image (Lower)
                    Transform.translate(
                      offset: const Offset(0, 40),
                      child: Transform.rotate(
                        angle: 0.1,
                        child: Container(
                          width: 220,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white, width: 8),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600'), // Adjusted dummy box image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
