import 'package:expense_manager/components/button/negative_button.dart';
import 'package:expense_manager/components/button/positive_button.dart';
import 'package:expense_manager/components/dialog/custom_dialog.dart';
import 'package:expense_manager/components/form/custom_text_field.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/material.dart';

class TextInputDialog extends StatelessWidget {
  final String hint;
  final String title;
  final TextEditingController controller;

  final VoidCallback onComplete;
  final FocusNode? focusNode;

  const TextInputDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.onComplete,
    this.hint = '',
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            CustomTextField(
              hint: hint,
              controller: controller,
              focusNode: focusNode,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NegativeButton(),
                PositiveButton(
                  onPressed: () {
                    onComplete();
                    goBack(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
