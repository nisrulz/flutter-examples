import 'package:flutter/material.dart';

class BottomBarContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final BorderRadius? borderRadius;

  const BottomBarContainer({
    super.key,
    required this.child,
    this.padding,
    this.color = Colors.white,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, -10), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
