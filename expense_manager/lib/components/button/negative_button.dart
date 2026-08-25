import 'package:flutter/material.dart';
import '../../misc/utils.dart';

class NegativeButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const NegativeButton({
    super.key,
    this.title = 'Cancel',
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => goBack(context),
      style: style ?? TextButton.styleFrom(foregroundColor: Colors.grey),
      child: Text(title),
    );
  }
}
