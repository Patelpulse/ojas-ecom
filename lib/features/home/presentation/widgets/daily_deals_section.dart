import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/daily_deal_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class DailyDealsSection extends StatefulWidget {
  const DailyDealsSection({super.key});

  @override
  State<DailyDealsSection> createState() => _DailyDealsSectionState();
}

class _DailyDealsSectionState extends State<DailyDealsSection> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: HomeController.instance,
      builder: (context, _) {
        final dailyDeals = HomeController.instance.dealProducts.map((p) => ProductModel.fromMap(p)).toList();
        final bool isMobile = Responsive.isMobile(context);
        final bool isTablet = Responsive.isTablet(context);

        // Grouping deals
        int maxOnScreen = isMobile ? 1 : (isTablet ? 2 : 3);
        int itemsPerPage = dailyDeals.length > 0 && dailyDeals.length < maxOnScreen 
            ? dailyDeals.length 
            : maxOnScreen;
        
        if (itemsPerPage == 0) itemsPerPage = 1;
        
        return CenteredContent(
          horizontalPadding: isMobile ? 16 : 40,
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header with Navigation
              Row(
                children: [
                  Text(
                    'Daily Deals',
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (dailyDeals.length > itemsPerPage) ...[
                    _navButton(Icons.chevron_left, () => _carouselController.previousPage()),
                    const SizedBox(width: 8),
                    _navButton(Icons.chevron_right, () => _carouselController.nextPage()),
                  ],
                ],
              ),
              const SizedBox(height: 32),
              
              if (dailyDeals.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 48, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text(
                        'Check back later for daily deals!',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              else
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: (dailyDeals.length / itemsPerPage).ceil(),
                  options: CarouselOptions(
                    height: isMobile ? 350 : 280,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 7),
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final int start = index * itemsPerPage;
                    final int end = (index + 1) * itemsPerPage;
                    final List<ProductModel> pageDeals = dailyDeals.sublist(
                      start,
                      end > dailyDeals.length ? dailyDeals.length : end,
                    );

                    return Row(
                      children: [
                        for (var i = 0; i < pageDeals.length; i++) ...[
                          Expanded(child: DailyDealCard(product: pageDeals[i])),
                          if (i < pageDeals.length - 1) const SizedBox(width: 24),
                        ],
                        // Fill remaining space if last page has fewer items
                        if (pageDeals.length < itemsPerPage)
                          for (var i = 0; i < itemsPerPage - pageDeals.length; i++)
                            const Expanded(child: SizedBox()),
                      ],
                    );
                  },
                ),
              
              const SizedBox(height: 32),
              // Pagination Dots
              if (dailyDeals.length > itemsPerPage)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    (dailyDeals.length / itemsPerPage).ceil(),
                    (index) => _pageDot(_currentIndex == index, index),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 20, color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _pageDot(bool active, int index) {
    return GestureDetector(
      onTap: () => _carouselController.animateToPage(index),
      child: Container(
        width: active ? 24 : 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFF01B6B) : Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
