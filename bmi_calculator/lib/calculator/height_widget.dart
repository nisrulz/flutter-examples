import 'package:flutter/material.dart';

import '../palette.dart';

class HeightWidget extends StatelessWidget {
  const HeightWidget({
    super.key,
    required this.height,
    required this.onHeightChanged,
  });

  final int height;
  final Function(double) onHeightChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 48) / 2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.cardBackgroundInactive,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'HEIGHT',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Palette.textInactive,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                height.round().toString(),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color: Palette.textActive,
                ),
              ),
              const Text(
                'cm',
                style: TextStyle(
                  fontSize: 30,
                  color: Palette.textInactive,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 1.0,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 15,
                ),
              ),
              child: Slider(
                value: height.toDouble(),
                min: 150.0,
                max: 210.0,
                activeColor: Palette.textActive,
                inactiveColor: Palette.textInactive,
                thumbColor: Palette.action,
                onChanged: onHeightChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
