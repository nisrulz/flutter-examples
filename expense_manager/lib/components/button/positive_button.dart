import 'package:expense_manager/misc/colors.dart';
import 'package:flutter/material.dart';

class PositiveButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  const PositiveButton({
    super.key,
    required this.onPressed,
    this.style,
    this.title = 'Done',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style:
          style ?? TextButton.styleFrom(foregroundColor: CustomColors.primary),
      child: Text(title),
    );
  }
}
