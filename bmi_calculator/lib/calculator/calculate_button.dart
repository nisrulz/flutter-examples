import 'package:flutter/material.dart';

import '../palette.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.action,
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.10)),
        ),
        onPressed: onTap,
        child: const Text(
          'CALCULATE YOUR BMI',
          style: TextStyle(
            color: Palette.textActive,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
