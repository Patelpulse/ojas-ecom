import 'package:flutter/material.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/features/home/domain/models/category_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryModel.dummyCategories;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFF01B6B), // Match the pinkish header in reference
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.list, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  'All Categories',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
          // Category List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 20, endIndent: 20),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: Text(category.icon ?? '📦', style: const TextStyle(fontSize: 18)),
                  title: Text(
                    category.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  onTap: () {},
                  dense: true,
                  hoverColor: AppColors.bgSecondaryLight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
