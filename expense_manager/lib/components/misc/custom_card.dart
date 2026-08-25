import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final bool noPadding;
  final double cardRadius;
  final GestureTapCallback? onTap;
  final Color? color;

  const CustomCard({
    super.key,
    this.child,
    this.noPadding = false,
    this.cardRadius = 8,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius)),
      elevation: 8,
      color: color,
      surfaceTintColor: color,
      child: InkWell(
        onTap: onTap,
        child: noPadding
            ? child
            : Padding(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
      ),
    );
  }
}
