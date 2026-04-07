import 'package:flutter/material.dart';
import 'package:ojas_user/features/home/domain/models/banner_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/banner_widget.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class PromoBannerSection extends StatelessWidget {
  const PromoBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Row(
          children: [
            Expanded(child: BannerWidget(banner: BannerModel.promoBanners[0])),
            const SizedBox(width: 24),
            Expanded(child: BannerWidget(banner: BannerModel.promoBanners[1])),
          ],
        ),
      ),
    );
  }
}
