import 'package:flutter/material.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class FavoriteProductCard extends StatelessWidget {
  final String carName;
  final String carImage;
  final String price;
  final String hp;
  final String transmission;
  final String seatCount;
  final VoidCallback onRemove; // Callback to handle list removal
  final VoidCallback onBookTap;

  const FavoriteProductCard({
    super.key,
    required this.carName,
    required this.carImage,
    required this.price,
    required this.hp,
    required this.transmission,
    required this.seatCount,
    required this.onRemove,
    required this.onBookTap,
  });

  /// Shows the confirmation dialog before removing the item
  void _showRemoveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const CustomText(
            text: "Remove from Favorites?",
            fontWeight: FontWeight.bold,
            fontSize: 16,
            maxLines: 2,
          ),
          content: CustomText(
            text: "Are you sure you want to remove the $carName from your favorites list?",
            fontSize: 14,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(text: "Cancel", color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRemove();
              },
              child: const CustomText(
                text: "Remove",
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text: carName,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _buildFavoriteButton(context),
              ],
            ),
            CustomText(
              text: "\$$price/day",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LocalImage(
                img: carImage,
                type: "png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildFixedTag("engine", "$hp hp"),
                _buildFixedTag("gear", transmission),
                _buildFixedTag("seat", "$seatCount seats"),
              ],
            ),
            const Spacer(),
            const SizedBox(height: 20),
            CustomButton(
              title: "Book Now",
              onTap: onBookTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRemoveConfirmation(context),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: const Icon(
          Icons.favorite,
          size: 20,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildFixedTag(String iconName, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 6),
            child: LocalImage(img: iconName, type: "svg", size: 18),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: CustomText(
              text: value,
              fontSize: 11,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}