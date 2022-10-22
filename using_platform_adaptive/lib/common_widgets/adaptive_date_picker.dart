import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:using_platform_adaptive/platform_adaptive.dart';

class AdaptiveDialog extends PlatformAdaptiveWidget {
  const AdaptiveDialog(
      {super.key,
      super.forcePlatform,
      required this.title,
      required this.actions,
      this.content});

  final String title;
  final Widget? content;
  final List<AdaptiveDialogAction> actions;

  @override
  Widget buildAndroid(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions,
    );
  }

  @override
  Widget buildIOS(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}

class AdaptiveDialogAction extends PlatformAdaptiveWidget {
  const AdaptiveDialogAction(
      {super.forcePlatform, this.onPressed, required this.text, super.key});

  final void Function()? onPressed;
  final String text;

  @override
  Widget buildAndroid(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }

  @override
  Widget buildIOS(BuildContext context) {
    return CupertinoDialogAction(onPressed: onPressed, child: Text(text));
  }
}
