import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Icon button widget built different
/// depends on [MaterialApp] or [CupertinoApp] ancestor.
class IconBtn extends StatelessWidget {
  /// Widget to use inside button.
  ///
  /// Typically [Icon] widget.
  final Widget icon;

  /// Function called when user tap on the button.
  ///
  /// Can be null. In this case button will be disabled.
  final VoidCallback? onTap;

  /// Tooltip for button.
  ///
  /// Applied only for material style buttons.
  /// It means only if widget has [MaterialApp] ancestor.
  final String? tooltip;

  /// Creates button with [icon] different
  /// depends on [MaterialApp] or [CupertinoApp] ancestor.
  const IconBtn({
    Key? key,
    required this.icon,
    this.onTap,
    this.tooltip
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMaterial =  Material.of(context) != null;

    return isMaterial
      ? _materialBtn()
      : _cupertinoBtn();
  }

  Widget _cupertinoBtn() =>
      CupertinoButton(
        padding: const EdgeInsets.all(0.0),
        child: icon,
        onPressed: onTap,
      );

  Widget _materialBtn() =>
     IconButton(
       icon: icon,
       tooltip: tooltip ?? "",
       onPressed: onTap,
    );
}
