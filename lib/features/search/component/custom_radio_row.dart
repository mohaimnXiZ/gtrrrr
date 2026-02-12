import 'package:flutter/material.dart';
import 'package:gtr/core/widgets/text.dart';

class CustomRadioRow extends StatelessWidget {
  final String label;
  final String value; // Changed from int to String
  final List<String> selectedValues; // Changed from List<int>
  final ValueChanged<List<String>> onChanged; // Changed from List<int>

  const CustomRadioRow({
    super.key,
    required this.label,
    required this.value,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Check if this specific string value is in the selection list
    final bool isSelected = selectedValues.contains(value);

    return InkWell(
      onTap: () {
        final newList = List<String>.from(selectedValues);
        isSelected ? newList.remove(value) : newList.add(value);
        onChanged(newList);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: label,fontSize: 14, fontWeight: FontWeight.w500,),
            _buildCircle(context, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(BuildContext context,bool isSelected) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.transparent : Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}