import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class ProductCard extends StatelessWidget {
  final String carName;
  final String carImage;
  final String carLogo;
  final String dailyPrice;
  final String monthlyPrice;
  final String? oldPrice;
  final List<String> tags;
  final VoidCallback onDetailsTap;
  final VoidCallback onPhoneTap;
  final VoidCallback onWhatsappTap;

  const ProductCard({
    super.key,
    required this.carName,
    required this.carImage,
    required this.carLogo,
    required this.dailyPrice,
    required this.monthlyPrice,
    this.oldPrice,
    required this.tags,
    required this.onDetailsTap,
    required this.onPhoneTap,
    required this.onWhatsappTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: LocalImage(
                      img: carImage,
                      type: "png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: -15,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const double logoSize = 50.0;
                        return Container(
                          width: logoSize,
                          height: logoSize,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: LocalImage(
                            img: carLogo,
                            type: "svg",
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Padding(
                // Added extra top padding (20) to account for the logo overlapping the text area
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: carName,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                        // ... rest of your code remains exactly the same
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: CustomIcon(icon: Iconsax.heart, size: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tags.map((tag) => _buildTag(tag)).toList(),
                      ),
                      const SizedBox(height: 12),

                      // Pricing
                      if (oldPrice != null)
                        CustomText(
                          text: oldPrice!,
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).hintColor,
                          fontSize: 14,
                          maxLines: 1,
                          maxChars: 15,
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: _buildPriceText("AED $dailyPrice/Day", context),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            flex: 1,
                            child: _buildPriceText("AED $monthlyPrice/Mo", context, isEnd: true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Features
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5, (index) => _buildFeatureIcon(Iconsax.bag, "2 Bags")),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // --- Action Buttons ---
            // This is now at the bottom of the Column due to MainAxisAlignment.spaceBetween
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      onTap: onDetailsTap,
                      title: "Car Details",
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildIconButton("phone", const Color(0xFF777777), onPhoneTap),
                  const SizedBox(width: 8),
                  _buildIconButton("whatsapp", const Color(0xFF25D366), onWhatsappTap),
                ],
              ),
            ),
          ],
        ),
      );
  }

  // --- Helpers ---
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFF3D923A).withAlpha(12),
      ),
      child: CustomText(text: text, fontSize: 12),
    );
  }

  Widget _buildPriceText(String text, BuildContext context, {bool isEnd = false}) {
    return CustomText(
      text: text,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      textAlign: isEnd ? TextAlign.end : TextAlign.start,
      fontSize: 16,
      maxLines: 1,
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Flexible(
      child: Column(
        children: [
          CustomIcon(icon: icon, size: 20),
          const SizedBox(height: 4),
          FittedBox(child: CustomText(text: label, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildIconButton(String icon, Color color, VoidCallback tap) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 48,
        child: CustomButton(
          onTap: tap,
          color: color,
          borderRadius: BorderRadius.circular(16),
          child: Center(child: LocalImage(img: icon, type: "svg", size: 24)),
        ),
      ),
    );
  }
}