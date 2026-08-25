import 'package:flutter/material.dart';

class SectionView extends StatelessWidget {
  final Widget child;
  final String title;
  final double top;
  final Widget? actionButton;

  const SectionView({
    super.key,
    required this.title,
    required this.child,
    this.top = 8,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (actionButton != null) actionButton!,
          ],
        ),
        child,
      ],
    );
  }
}
