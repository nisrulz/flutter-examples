import 'package:expense_manager/controllers/tag_expenses_controller.dart';
import 'package:expense_manager/controllers/tags_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'text_input_dialog.dart';

class TagListItem extends StatelessWidget {
  final Tag tag;
  final TagsController controller;
  final bool hideAmount;

  const TagListItem({
    super.key,
    required this.tag,
    required this.controller,
    this.hideAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      onTap: () => gotoPage(
        context,
        ExpensesPage(
          pageTitle: "#${tag.name}",
          controller: TagExpensesController(tagId: tag.id!),
        ),
      ),
      leading: Icon(
        Icons.tag,
        color: Colors.grey,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tag.name),
          Text(obfuscateText(tag.totalAmountCents.toMoney(),
              obfuscate: hideAmount)),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text('Rename'),
              onTap: () {
                Future.delayed(Duration.zero, () {
                  _showTagRenameDialog(context, tag);
                });
              },
            ),
            PopupMenuItem(
              child: Text('Delete'),
              onTap: () {
                Future.delayed(Duration.zero, () {
                  _showTagDeletionDialog(context, tag);
                });
              },
            ),
          ];
        },
        child: Icon(Icons.more_vert),
      ),
    );
  }

  void _showTagDeletionDialog(BuildContext context, Tag tag) {
    showDecisionDialog(
      context,
      title: "Delete this Tag (${tag.name})?",
      positiveButtonText: "Delete",
      onPositivePressed: () => controller.deleteTag(tag),
    );
  }

  void _showTagRenameDialog(BuildContext context, Tag tag) {
    showDialog(
      context: context,
      builder: (context) {
        return TextInputDialog(
          controller: controller.renameController..text = tag.name,
          title: "Rename \"${tag.name}\"",
          focusNode: FocusNode()..requestFocus(),
          onComplete: () =>
              controller.renameTag(tag, controller.renameController.text),
        );
      },
    );
  }
}
