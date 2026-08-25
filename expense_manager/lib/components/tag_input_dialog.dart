import 'package:expense_manager/components/tag_chip.dart';
import 'package:expense_manager/controllers/tag_input_controller.dart';
import 'package:expense_manager/components/dialog/custom_dialog.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class TagInputDialog extends StatelessWidget {
  final List<Tag> tags;
  final ValueChanged<List<Tag>> onChange;

  const TagInputDialog({
    super.key,
    required this.tags,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: GetBuilder<TagInputController>(
          init: TagInputController(tags: tags),
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // search field
                _buildSearchField(controller),

                SizedBox(height: 32),
                Divider(),

                // tags result
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Wrap(
                      children: controller.tags.map((e) {
                        return TagChip(
                          text: e.name,
                          onDeleted: () {
                            controller.removeTag(e);
                            onChange(controller.tags);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // close button
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () => goBack(context),
                          child: Text('Close'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _buildSearchField(TagInputController controller) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TypeAheadField<Tag>(
              focusNode: controller.focusNode,
              controller: controller.inputController,
              emptyBuilder: (context) {
                if (controller.newTagText.trim().isEmpty) {
                  return SizedBox();
                }
                return InkWell(
                  onTap: () async {
                    await controller.addTag(controller.newTagText);
                    onChange(controller.tags);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.newTagText),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                return controller.searchTag(pattern);
              },
              onSelected: (Tag suggestion) async {
                await controller.addTag(suggestion.name);
                onChange(controller.tags);
              },
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(hintText: "Search or add tags"),
                );
              },
              itemBuilder: (context, itemData) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(itemData.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
