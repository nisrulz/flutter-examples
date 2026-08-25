import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/components/dialog/custom_dialog.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountDialog extends StatelessWidget {
  final int amount;
  final ValueChanged<int> onAmountChanged;

  const AmountDialog({
    super.key,
    this.amount = 0,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      maxWidth: 600,
      child: GetBuilder<_AmountDialogController>(
          init: _AmountDialogController(amount: amount),
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
                  child: Text(
                    controller.amount.toMoney(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),

                // number pads
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 2.3,
                  children: controller.keys.map((numKey) {
                    return InkWell(
                      onTap: () {
                        controller.calculateAmount(numKey);
                      },
                      child: Center(
                        child: numKey == 'back'
                            ? Icon(Icons.backspace)
                            : Text(numKey, style: TextStyle(fontSize: 21)),
                      ),
                    );
                  }).toList(),
                ),

                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () => goBack(context),
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          onAmountChanged.call(controller.amount);
                          goBack(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _AmountDialogController extends GetxController {
  final List<String> keys = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    'back'
  ];
  int amount;

  _AmountDialogController({required this.amount});

  void calculateAmount(String numKey) {
    if (numKey.isEmpty) return;

    switch (numKey) {
      case 'back':
        String amountText = amount.toString();
        amountText = amountText.length <= 1
            ? '0'
            : amountText.substring(0, amountText.length - 1);
        amount = int.parse(amountText);
        break;
      default:
        final amountText = amount.toString() + numKey;
        amount = int.parse(amountText);
    }

    update();
  }
}
