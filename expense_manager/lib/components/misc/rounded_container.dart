import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final double radius;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const RoundedContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.radius = 8,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFD3D3D3)),
      ),
      padding: padding ?? EdgeInsets.all(16),
      child: child,
    );

    return onTap != null
        ? InkWell(
            onTap: onTap,
            child: widget,
          )
        : widget;
  }
}
