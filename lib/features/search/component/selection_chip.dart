import 'package:flutter/material.dart';
import '../../../core/widgets/text.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onSelected;
  final bool withColor;

  const SelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.withColor = false,
  });

  static const Map<String, Color> colorMap = {
    "White": Color(0xFFEDEDED),
    "Black": Color(0xFF000000),
    "Grey": Color(0xFFA1A1A1),
    "Silver": Color(0xFF8A8A8A),
    "Gold": Color(0xFFFACC15),
    "Yellow": Colors.yellow,
    "Orange": Colors.orange,
    "Brown": Color(0xFF854D0E),
    "Red": Color(0xFF9C0606),
    "Blue": Color(0xFF1C3FEB),
    "Purple": Colors.purple,
    "Green": Color(0xFF15803D),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (withColor) ...[
              Padding(
                padding: EdgeInsetsGeometry.only(bottom: 3),
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: colorMap[label],
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: CustomText(
                text: label,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}