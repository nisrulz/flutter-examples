import 'package:flutter/material.dart';
import '../../misc/utils.dart';
import '../button/custom_button.dart';
import 'custom_dialog.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;
  final Widget? subtitle;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.onDelete,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            if (subtitle != null) subtitle!,
            const Padding(padding: EdgeInsets.all(8)),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    'Cancel',
                    color: Colors.white,
                    textColor: Colors.grey.shade700,
                    borderColor: Colors.grey,
                    onPressed: () => goBack(context),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4)),
                Expanded(
                  child: CustomButton(
                    'Delete',
                    color: Colors.red,
                    onPressed: () => onDelete.call(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
