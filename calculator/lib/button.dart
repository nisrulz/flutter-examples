import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final dynamic buttonTapped;
  final Color? color;
  final Color? textColor;
  final String? buttonText;

  const MyButton(
      {super.key,
      this.buttonTapped,
      this.color,
      this.textColor,
      this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText!,
                style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
