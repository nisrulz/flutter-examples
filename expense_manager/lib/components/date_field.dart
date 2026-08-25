import 'package:expense_manager/components/form/custom_text_field.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onChange;

  const DateField({
    super.key,
    required this.initialDate,
    required this.onChange,
  });

  get dateLabel => formatDate(initialDate, 'dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(context),
      child: CustomTextField(
        label: "Date",
        editable: false,
        useCustomLabel: true,
        isDense: true,
        text: dateLabel,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 100 * 365)),
      lastDate: DateTime.now().add(Duration(days: 100 * 365)),
    );
    if (date == null) return;
    onChange.call(date);
  }
}
