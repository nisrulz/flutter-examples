import 'package:expense_manager/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'amount_dialog.dart';

class AmountInputView extends StatelessWidget {
  final int initialAmount;
  final ValueChanged<int> onChange;

  const AmountInputView({
    super.key,
    this.initialAmount = 0,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showAmountDialog(context),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            initialAmount.toMoney(),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  void _showAmountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AmountDialog(
        amount: initialAmount,
        onAmountChanged: (int amount) {
          onChange.call(amount);
        },
      ),
    );
  }
}
