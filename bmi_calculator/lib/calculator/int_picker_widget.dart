import 'package:bmi_calculator/palette.dart';
import 'package:flutter/material.dart';

class IntPickerWidget extends StatelessWidget {
  const IntPickerWidget({
    super.key,
    required this.title,
    required this.onIncreaseTap,
    required this.onDecreaseTap,
    required this.value,
  });

  final String title;
  final VoidCallback onIncreaseTap;
  final VoidCallback onDecreaseTap;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.cardBackgroundInactive,
      ),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Palette.textInactive,
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w800,
              color: Palette.textActive,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onDecreaseTap,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cardBackgroundActive,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Palette.textActive,
                  ),
                ),
              ),
              InkWell(
                onTap: onIncreaseTap,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cardBackgroundActive,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Palette.textActive,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
