import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/cupertino.dart';

class CategorySquareBox extends StatelessWidget {
  final String? colorCode;

  const CategorySquareBox({
    super.key,
    this.colorCode,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: hexToColor(colorCode ?? '#EEEEEE'),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox.square(dimension: 30),
    );
  }
}
