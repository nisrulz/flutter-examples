import 'package:expense_manager/components/transaction_list_item.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionGroupItem extends StatelessWidget {
  final bool hideAmount;
  final bool initiallyExpanded;
  final String groupName;
  final List<Transaction> transactions;

  const TransactionGroupItem({
    super.key,
    required this.transactions,
    this.hideAmount = false,
    this.initiallyExpanded = false,
    this.groupName = '',
  });

  @override
  Widget build(BuildContext context) {
    final totalSum = transactions.sumAmounts();
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Color(0xFFE6E6E6)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        controlAffinity: ListTileControlAffinity.leading,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              groupName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              obfuscateText(
                totalSum.toMoney(),
                obfuscate: hideAmount,
              ),
              style: TextStyle(
                color: totalSum.isNegative ? Colors.red : Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: transactions.map((e) {
          return TransactionListItem(
            transaction: e,
            hideAmount: hideAmount,
          );
        }).toList(),
      ),
    );
  }
}
