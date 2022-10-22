import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:using_platform_adaptive/platform_adaptive.dart';

class AdaptiveButton extends PlatformAdaptiveWidget {
  const AdaptiveButton(
      {super.forcePlatform,
      this.color,
      required this.child,
      this.onPressed,
      super.key});

  final void Function()? onPressed;
  final Widget child;
  final Color? color;

  @override
  Widget buildAndroid(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: child,
    );
  }

  @override
  Widget buildIOS(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      color: color,
      child: child,
    );
  }
}
