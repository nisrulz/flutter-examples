import 'package:expense_manager/components/action_delete_icon.dart';
import 'package:expense_manager/components/amount_input_view.dart';
import 'package:expense_manager/components/date_field.dart';
import 'package:expense_manager/controllers/add_income_controller.dart';
import 'package:expense_manager/components/button/custom_button.dart';
import 'package:expense_manager/components/form/custom_text_field.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncomePage extends StatelessWidget {
  final Income? income;

  const AddIncomePage({
    super.key,
    this.income,
  });

  AddIncomeController get _controller => Get.find<AddIncomeController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Income",
      appBarActions: [
        ActionDeleteIcon(onTap: () => _showDeletionDialog(context)),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GetBuilder<AddIncomeController>(
              init: AddIncomeController(income ?? Income()),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // amount
                    AmountInputView(
                      initialAmount: controller.income.amountCents,
                      onChange: (value) => controller.updateAmount(value),
                    ),

                    Divider(),

                    DateField(
                      initialDate: controller.income.date,
                      onChange: (date) => controller.updateDate(date),
                    ),

                    SizedBox(height: 8),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text('Notes'),
                      title: CustomTextField(
                        border: UnderlineInputBorder(),
                        controller: controller.noteController,
                      ),
                    ),

                    SizedBox(height: 32),

                    // save button
                    CustomButton(
                      "Save",
                      onPressed: () {
                        controller.save().then((value) => goBack(context));
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context) {
    showDecisionDialog(
      context,
      title: "Delete this income?",
      onPositivePressed: () {
        _controller.deleteIncome().then((value) => goBack(context));
      },
    );
  }
}
