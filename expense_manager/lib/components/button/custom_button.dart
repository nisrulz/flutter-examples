import 'package:flutter/material.dart';
import '../../misc/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BorderRadius borderRadius;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Color? shadowColor;
  final Icon? leftIcon;
  final Icon? rightIcon;
  final EdgeInsetsGeometry? padding;
  final double elevation;
  final bool disabled;
  final bool loading;
  final double? height;
  final bool useCustomShape;

  const CustomButton(
    this.text, {
    super.key,
    this.onPressed,
    this.disabled = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.color = CustomColors.primary,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.leftIcon,
    this.rightIcon,
    this.padding,
    this.shadowColor,
    this.elevation = 0,
    this.loading = false,
    this.height,
    this.useCustomShape = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          elevation: 2,
          shadowColor: shadowColor,
          shape: useCustomShape
              ? RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor,
                  ),
                  borderRadius: borderRadius,
                )
              : null,
        ),
        onPressed: disabled
            ? null
            : () {
                if (loading) return;
                onPressed?.call();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null)
              Align(
                alignment: Alignment.centerLeft,
                child: leftIcon,
              ),
            Align(
              alignment: Alignment.center,
              child: loading
                  ? _renderProgressBar()
                  : Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
            ),
            if (rightIcon != null)
              Align(
                alignment: Alignment.centerRight,
                child: rightIcon,
              )
          ],
        ),
      ),
    );
  }

  Widget _renderProgressBar() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
        strokeWidth: 2,
      ),
    );
  }
}
