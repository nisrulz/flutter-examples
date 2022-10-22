import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class PlatformAdaptiveWidget extends StatelessWidget {
  const PlatformAdaptiveWidget({super.key, this.forcePlatform});

  final TargetPlatform? forcePlatform;

  @override
  Widget build(BuildContext context) {
    switch (forcePlatform ?? defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return buildIOS(context);
      default:
        return buildAndroid(context);
    }
  }

  Widget buildIOS(BuildContext context);
  Widget buildAndroid(BuildContext context);
}
