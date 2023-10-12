import 'package:bmi_calculator/palette.dart';
import 'package:flutter/material.dart';

import '../body_model.dart';

class SexWidget extends StatelessWidget {
  const SexWidget({
    super.key,
    required this.sex,
    required this.onMaleTap,
    required this.onFemaleTap,
  });

  final Sex sex;
  final VoidCallback onMaleTap;
  final VoidCallback onFemaleTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 48) / 2,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onMaleTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: sex == Sex.male
                      ? Palette.cardBackgroundActive
                      : Palette.cardBackgroundInactive,
                ),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.male_rounded,
                      size: 100,
                      color: sex == Sex.male
                          ? Palette.textActive
                          : Palette.textInactive,
                    ),
                    Text(
                      'MALE',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: sex == Sex.male
                            ? Palette.textActive
                            : Palette.textInactive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onFemaleTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: sex == Sex.female
                      ? Palette.cardBackgroundActive
                      : Palette.cardBackgroundInactive,
                ),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female_rounded,
                      size: 100,
                      color: sex == Sex.female
                          ? Palette.textActive
                          : Palette.textInactive,
                    ),
                    Text(
                      'FEMALE',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: sex == Sex.female
                            ? Palette.textActive
                            : Palette.textInactive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
