import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final Widget widget;
  final String label;
  const LabelWidget({
    super.key,
    required this.widget,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        widget,
      ],
    );
  }
}
