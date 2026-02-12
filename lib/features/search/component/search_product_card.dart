import 'package:flutter/material.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class SearchProductCard extends StatefulWidget {
  final String carName;
  final String carImage;
  final String price;
  final String hp;
  final String transmission;
  final String seatCount;
  final bool initialFavorite;
  final Function(bool)? onFavoriteChanged;
  final VoidCallback onBookTap;

  const SearchProductCard({
    super.key,
    required this.carName,
    required this.carImage,
    required this.price,
    required this.hp,
    required this.transmission,
    required this.seatCount,
    this.initialFavorite = false,
    this.onFavoriteChanged,
    required this.onBookTap,
  });

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialFavorite;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    _controller.forward().then((_) => _controller.reverse());
    if (widget.onFavoriteChanged != null) {
      widget.onFavoriteChanged!(_isFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decoration for the card background
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // mainAxisSize.max is essential here so the card expands
          // to the height provided by the IntrinsicHeight in SearchGrid
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Car Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LocalImage(
                img: widget.carImage,
                type: "png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            // 2. Title & Favorite
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.carName,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _buildFavoriteButton(),
              ],
            ),

            const SizedBox(height: 4),

            // 3. Price
            CustomText(
              text: "\$${widget.price}/day",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              maxLines: 1,
            ),

            const SizedBox(height: 16),

            // 4. Specs Tags
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildFixedTag("engine", "${widget.hp} hp"),
                _buildFixedTag("gear", widget.transmission),
                _buildFixedTag("seat", "${widget.seatCount} seats"),
              ],
            ),

            // 5. Dynamic Expansion
            // This Spacer pushes the button to the bottom if the row's
            // tallest item is taller than this specific card's content.
            const Spacer(),
            const SizedBox(height: 20),

            // 6. Action Button
            CustomButton(
              title: "Book Now",
              onTap: widget.onBookTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: _toggleFavorite,
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        ),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: _isFavorite ? Colors.red : Colors.grey,
          ),
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