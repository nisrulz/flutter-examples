import 'package:expense_manager/components/action_delete_icon.dart';
import 'package:expense_manager/components/amount_input_view.dart';
import 'package:expense_manager/components/category_editor_dialog.dart';
import 'package:expense_manager/components/date_field.dart';
import 'package:expense_manager/components/section_view.dart';
import 'package:expense_manager/components/category_radio_button.dart';
import 'package:expense_manager/components/tag_chip.dart';
import 'package:expense_manager/components/tag_input_dialog.dart';
import 'package:expense_manager/controllers/add_expense_controller.dart';
import 'package:expense_manager/components/button/custom_button.dart';
import 'package:expense_manager/components/form/custom_text_field.dart';
import 'package:expense_manager/components/misc/bottom_bar_container.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpensePage extends StatelessWidget {
  final Expense? expense;

  const AddExpensePage({
    super.key,
    this.expense,
  });

  AddExpenseController get _controller => Get.find<AddExpenseController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Expense',
      appBarActions: [
        ActionDeleteIcon(onTap: () => _showDeletionDialog(context)),
      ],
      bottomNavigationBar: BottomBarContainer(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: CustomButton(
          'Save',
          onPressed: () => _saveExpense(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GetBuilder<AddExpenseController>(
              init: AddExpenseController(expense ?? Expense()),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // amount
                    AmountInputView(
                      initialAmount: controller.expense.amountCents,
                      onChange: (int amount) =>
                          _controller.updateAmount(amount),
                    ),

                    Divider(),

                    // categories
                    SectionView(
                      title: 'CATEGORY',
                      actionButton: IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () => _showCategoryDialog(context),
                      ),
                      child: Column(
                        children: [
                          ...controller.categories.map((category) {
                            return CategoryRadioButton(
                              title: category.name ?? '',
                              color:
                                  hexToColor(category.colorCode ?? '#000000'),
                              value: category.id!,
                              currentValue:
                                  controller.expense.category.value?.id ??
                                      controller.categories.first.id!,
                              onChange: (categoryId) =>
                                  controller.setCategory(categoryId),
                            );
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // date & notes
                    DateField(
                      initialDate: controller.expense.date,
                      onChange: (date) => _controller.updateDate(date),
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Notes',
                      useCustomLabel: true,
                      isDense: true,
                      controller: controller.noteController,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),

                    SizedBox(height: 32),

                    // more info
                    SectionView(
                      title: 'MORE INFO',
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              'Tags',
                              style: TextStyle(fontSize: 15),
                            ),
                            title: Wrap(
                              children: controller.tags.map((tag) {
                                return TagChip(
                                  text: tag.name,
                                  onDeleted: () =>
                                      controller.removeTagFromExpense(tag),
                                );
                              }).toList(),
                            ),
                            trailing: IconButton(
                              onPressed: () => _showTagInputDialog(context),
                              icon: Icon(Icons.add, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _saveExpense(BuildContext context) {
    _controller.saveExpense();
    goBack(context);
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CategoryEditorDialog(
          onComplete: () => _controller.loadCategories(),
        );
      },
    );
  }

  void _showDeletionDialog(BuildContext context) {
    showDecisionDialog(
      context,
      title: "Delete this expense?",
      onPositivePressed: () {
        _controller.deleteExpense().then((value) => goBack(context));
      },
    );
  }

  void _showTagInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return TagInputDialog(
          tags: _controller.tags.toList(),
          onChange: (tags) {
            _controller.updateTags(tags);
          },
        );
      },
    );
  }
}
