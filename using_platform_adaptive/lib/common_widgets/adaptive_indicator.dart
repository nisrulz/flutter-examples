import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:using_platform_adaptive/platform_adaptive.dart';

class AdaptiveIndicator extends PlatformAdaptiveWidget {
  const AdaptiveIndicator({super.forcePlatform, super.key});

  @override
  Widget buildAndroid(BuildContext context) {
    return const CircularProgressIndicator();
  }

  @override
  Widget buildIOS(BuildContext context) {
    return const CupertinoActivityIndicator();
  }
}
