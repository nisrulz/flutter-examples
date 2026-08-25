import 'package:expense_manager/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'category_square_box.dart';

class CategoryRadioButton extends StatelessWidget {
  final String title;
  final Color color;
  final int value;
  final int currentValue;
  final ValueChanged<int> onChange;

  const CategoryRadioButton({
    super.key,
    required this.title,
    required this.onChange,
    required this.value,
    required this.currentValue,
    this.color = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange.call(value),
      child: Row(
        children: [
          CategorySquareBox(colorCode: color.toHex()),
          SizedBox(width: 16),
          Expanded(child: Text(title)),
          SizedBox(width: 8),
          Radio<int?>(
            value: value,
            groupValue: currentValue,
            visualDensity: VisualDensity.compact,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
