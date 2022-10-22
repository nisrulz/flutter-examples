import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int length;
  final int selected;

  const CarouselIndicator(
      {Key key, @required this.length, @required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (i) {
            var active = i == selected;
            return Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 5),
            );
          },
        ),
      ),
    );
  }
}
